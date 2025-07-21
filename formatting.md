⏺ What I Learned: Debugging Template Date Range Calculation

  The Problem

  User wanted company date ranges to auto-calculate from positions arrays, showing "November 2020 – Present" (earliest start to latest end) instead of just the current position's "September 2022 – Present".

  Key Discoveries Through Debugging

  1. RenderCV Does Support Custom Fields

  Initial assumption: RenderCV strips out custom fields like positions array
  Reality: The positions field WAS available to the template - individual positions were rendering correctly

  2. Jinja2 Variable Scoping is Tricky

  The core issue: Variables set inside ((* for *)) loops don't persist outside the loop scope
  ((* for position in entry.positions *))
    ((* set company_start_date = position.start_date *))  // Local scope only!
  ((* endfor *))
  // company_start_date reverts to previous value here

  3. Debug-Driven Development is Essential

  Method: Added visible debug output directly in the PDF to trace variable values:
  CALC_INIT_<<company_start_date>>_<<company_end_date>>_CALC
  CALC_FINAL_<<company_start_date>>_<<company_end_date>>_CALC
  FORMAT_INPUT_<<company_start_date>>_<<company_end_date>>_FORMAT

  Key insight: The calculation worked correctly (CALC_LOOP_END_2020-11_present) but variables got reset afterwards (CALC_FINAL_2022-09_present)

  4. The Working Solution

  Failed approaches:
  - Using loops with variable updates (scoping issues)
  - Separate loops for start/end dates (still scoping issues)
  - Try-catch blocks (not supported in Jinja2)

  Successful approach: Direct comparison without loops
  ((* if entry.positions|length == 2 *))
    ((* if entry.positions[0].start_date < entry.positions[1].start_date *))
      ((* set company_start_date = entry.positions[1].start_date *))
    ((* else *))
      ((* set company_start_date = entry.positions[0].start_date *))
    ((* endif *))
  ((* endif *))

  Debugging Methodology That Worked

  1. Visible Output Method

  - Added debug statements that render directly in the PDF
  - Traced variables at each step of the calculation
  - Could see exactly where values got corrupted

  2. Iterative Hypothesis Testing

  1. Hypothesis 1: RenderCV doesn't pass positions field → False (positions were rendering)
  2. Hypothesis 2: Date calculation logic is wrong → False (calculation worked in loop)
  3. Hypothesis 3: Variable scoping issue → True (confirmed by debug traces)

  3. Root Cause Analysis

  - Identified the exact moment variables got reset (between CALC_LOOP_END and CALC_FINAL)
  - Understood this was a Jinja2 templating engine limitation, not a RenderCV issue
  - Found workaround that avoided the problematic language feature

  Technical Lessons

  1. Jinja2 Template Engine Limitations

  - Loop variables have local scope
  - Variables set inside conditional blocks within loops don't persist
  - Need to use direct assignment outside loops for persistent changes

  2. RenderCV Template Architecture

  - Custom YAML fields ARE passed to templates (contrary to initial assumption)
  - The ahmadstyle theme processes both standard and custom fields
  - Schema validation is lenient enough to allow additional fields

  3. Effective Debugging Strategies

  - Visual debugging: Put debug output where you can see it (PDF in this case)
  - Granular tracing: Debug at every step, not just inputs/outputs
  - Hypothesis-driven: Form specific theories and test them systematically

  Key Takeaway

  The most important lesson: Don't assume what the problem is - let the debug output tell you. I initially thought RenderCV was the issue, but systematic debugging revealed it was actually a Jinja2 templating scoping limitation. The
  solution required understanding the specific constraints of the templating engine, not the CV generation framework.
