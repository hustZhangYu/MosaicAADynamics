"""Historical entry point; the identical figure implementation lives in ReplyCodes."""
from pathlib import Path
import runpy

_data_dir = Path(__file__).resolve().parent
_script = _data_dir.parents[1] / 'ReplyCodes' / 'Fig1code' / 'Fig1Plot2.py'
_namespace = runpy.run_path(
    str(_script), run_name=__name__, init_globals={'DATA_DIR': _data_dir}
)
# Preserve helper names for callers importing this historical entry point.
globals().update({key: value for key, value in _namespace.items()
                  if not key.startswith('__')})

