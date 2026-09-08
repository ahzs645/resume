"""Run with Python 3.12+ and RenderCV 2.8: pytest classicserif/tests."""
import importlib.util
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]


def load(name):
    spec = importlib.util.spec_from_file_location(name, ROOT / name / '__init__.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return getattr(module, name.capitalize() + 'Theme')


def test_presets_share_layout_but_change_order_and_density():
    theme = load('classicserif')
    jake = theme(preset='jake')
    carolyn = theme(preset='carolyn')
    assert jake.templates.experience_entry.main_column.startswith('**POSITION**')
    assert carolyn.templates.experience_entry.main_column.startswith('**COMPANY**')
    assert jake.typography.line_spacing != carolyn.typography.line_spacing
    for design in [jake, carolyn]:
        assert design.header.connections.hyperlink
        assert design.links.underline
        assert not design.entries.allow_page_break
        assert design.sections.allow_page_break
        assert design.page.top_margin == '0.5in'


def test_nested_overrides_win_without_mutating_presets():
    theme = load('classicserif')
    design = {'preset': 'jake', 'typography': {'font_size': {'body': '11pt'}},
              'links': {'underline': False}, 'entries': {'allow_page_break': True}}
    modified = theme.model_validate(design)
    assert modified.typography.font_size.body == '11pt'
    assert modified.typography.font_size.name == '18pt'
    assert modified.typography.line_spacing == '0.5em'
    assert not modified.links.underline
    assert modified.entries.allow_page_break
    assert theme(preset='jake').typography.font_size.body == '10pt'
    assert design['typography'] == {'font_size': {'body': '11pt'}}


@pytest.mark.parametrize(('alias', 'preset'), [('phdjakes', 'jake'), ('carolynstyle', 'carolyn')])
def test_old_names_delegate_to_shared_defaults_and_templates(alias, preset):
    legacy = load(alias)().model_dump(exclude={'theme'})
    shared = load('classicserif')(preset=preset).model_dump(exclude={'theme'})
    assert legacy == shared
    for path in (ROOT / alias).rglob('*.j2.typ'):
        assert path.read_text().startswith("{% include 'classicserif/")


def test_invalid_preset_is_rejected():
    with pytest.raises(ValueError, match='preset'):
        load('classicserif')(preset='missing')


@pytest.mark.parametrize('preset', ['jake', 'carolyn'])
def test_independent_experience_order(preset):
    theme = load('classicserif')
    baseline = theme(preset=preset)
    for order, first in [('company_first', 'COMPANY'), ('position_first', 'POSITION')]:
        changed = theme(preset=preset, experience_order=order)
        assert changed.templates.experience_entry.main_column.startswith('**' + first + '**')
        assert changed.typography == baseline.typography
        assert changed.sections == baseline.sections
    custom = theme(preset=preset, experience_order='company_first', templates={'experience_entry': {'main_column': 'POSITION'}})
    assert custom.templates.experience_entry.main_column == 'POSITION'


def test_continuation_role_keeps_first_bullet_and_normal_url():
    from jinja2 import Environment, FileSystemLoader
    from types import SimpleNamespace
    env = Environment(loader=FileSystemLoader(str(ROOT)))
    theme = load('classicserif')
    for preset in ['jake', 'carolyn']:
        design = theme(preset=preset)
        macro = env.get_template('classicserif/components/entry.j2.typ').make_module({'design': design}).aligned_entry
        entry = SimpleNamespace(main_column='#strong[Analyst]\n- First detail\n- Second detail', position='Analyst', company='', date_and_location_column='2024', location='', date='2024', start_date=None, end_date=None)
        result = macro(entry, 2, 'experience')
        assert result.count('- First detail') == 1
        assert result.count('- Second detail') == 1
        entry = SimpleNamespace(main_column='#strong[Project]\nDescription', url='https://example.com/project', technologies='', date_and_location_column='')
        result = macro(entry, 1, 'normal')
        assert '#link("https://example.com/project")[#strong[Project]]' in result
        assert 'Description' in result


def test_nested_roles_share_company_heading_and_keep_role_dates_and_details():
    from jinja2 import Environment, FileSystemLoader
    from types import SimpleNamespace as Obj
    env = Environment(loader=FileSystemLoader(str(ROOT)))
    first = Obj(company='Example Lab', position='Lead', location='Vancouver', date=None, start_date='2022', end_date='present', date_and_location_column='2022 – present\nVancouver', main_column='Lead\nExample Lab\n- Lead detail')
    second = Obj(company='', position='Assistant', location='Vancouver', date=None, start_date='2020', end_date='2022', date_and_location_column='2020 – 2022\nVancouver', main_column='Assistant\n- Assistant detail')
    cv = Obj(rendercv_sections=[Obj(entries=[first, second])])
    for preset in ['jake', 'carolyn']:
        macro = env.get_template('classicserif/components/entry.j2.typ').make_module({'design': load('classicserif')(preset=preset), 'cv': cv}).aligned_entry
        result = macro(first, 2, 'experience') + macro(second, 2, 'experience')
        assert result.count('Example Lab') == 1
        assert result.count('Vancouver') == 1
        assert '#emph[Lead]' in result and '#emph[Assistant]' in result
        assert '#strong[Lead]' not in result and '#strong[Assistant]' not in result
        assert '2022 – present' in result and '2020 – 2022' in result
        assert result.count('- Lead detail') == 1
        assert result.count('- Assistant detail') == 1
        assert '#emph[]' not in result
        assert '#pad(left: 0.12in)' not in result
        indented = env.get_template('classicserif/components/entry.j2.typ').make_module({
            'design': load('classicserif')(preset=preset, indent_nested_jobs=True), 'cv': cv
        }).aligned_entry
        assert '#pad(left: 0.12in)' in indented(first, 2, 'experience')
        assert '#pad(left: 0.12in)' in indented(second, 2, 'experience')


def test_presentation_metadata_stacks_independently_of_title():
    from jinja2 import Environment, FileSystemLoader
    from types import SimpleNamespace as Obj
    env = Environment(loader=FileSystemLoader(str(ROOT)))
    entry = Obj(name='Long presentation title', date='2025', start_date=None, end_date=None, summary='Annual Conference', location='Buffalo, NY', url='https://example.com/talk', technologies='', highlights=[], date_and_location_column='Jan 2025\nBuffalo, NY')
    result = env.get_template('classicserif/entries/NormalEntry.j2.typ').render(design=load('classicserif')(), entry=entry)
    assert 'columns: (1fr, calc.min(2.1in, 1.25in))' in result
    assert 'Annual Conference' in result
    assert '#grid(columns: (1fr,), row-gutter: 0.4em, align: right,' in result
    assert '[#emph[Buffalo, NY]]' in result
    assert '#link("https://example.com/talk")[Long presentation title]' in result

    assert '[2025]' in result
    assert 'Jan 2025' not in result
