source /home/neg/.gdb/gdb-stl-views.gdb
#source /home/neg/.gdb/dbinit_stl_views-1.03.txt
python
import sys
sys.path.insert(0, '/home/neg/.gdb/boost_pretty_printer')
from boost.printers import register_printer_gen
register_printer_gen(None)
end
source /home/neg/src/1st_level/peda/peda.py
