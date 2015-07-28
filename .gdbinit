source /home/neg/.gdb/gdb-stl-views.gdb
python
import sys
sys.path.insert(0, '/home/neg/.gdb/boost_pretty_printer')
from boost.printers import register_printer_gen
register_printer_gen(None)
end
