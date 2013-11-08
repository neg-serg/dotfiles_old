import os
import ConfigParser
import urllib2
import feedparser
import json


#Tool to automatically find torrents to download. Works with transmission-daemon as the engine. 
#Can be set in the config to search for certian patterns, like "720" or "1080"


class ThePirateBay():
    def __init__(self):
        #Open the config file, read the contents and start the parsing.
        self.td = 0
        self.downloaded = []
	self.default_config_dir = os.path.expanduser("~/.auto_torrent")
	self.default_config = "%s/%s" % (self.default_config_dir, "config")
	self.default_watch_dir = os.path.expanduser("~/.auto_torrent/to_download")
        self.download_list = os.path.expanduser("~/.auto_torrent/download_list")
        cfg = ConfigParser.RawConfigParser()
	
	if os.path.exists(self.default_config):
	    cfg.readfp(open(self.default_config))
	    self.matches = cfg.get("match", "list")
	    self.watch_dir = cfg.get("options", "watch_dir")
	    self.download_program = cfg.get("options", "download_program")
	    self.detect_dup = cfg.getboolean("options", "duplicate_detection")
	    
	    #Start the retrieval 
	    for item in cfg.items("feeds"):
		if item[0] == "rss":
		    self.parse_rss(item[1], 0)
	    
	else:
	    self.init_tpb()
    
    def init_tpb(self):
	
	try:
	    if os.path.exists(self.default_config_dir):
		pass
	    else:
		os.mkdir(self.default_config_dir)
		print "Config folder created"
		
	except:
	    print "Could not create %s" % self.default_config_dir
	    exit()
	    
	try:
	    if os.path.exists(self.default_watch_dir):
		pass
	    else:
		os.mkdir(self.default_watch_dir)
		print "Watch dir created (%s)" % self.default_watch_dir
	except:
	    print "Could not create watch dir" % self.default_watch_dir
	    exit()
	    
	cfg = ConfigParser.RawConfigParser()
	
	print "Creating default config"
	
	sections = ["match", "options", "feeds"]
	for s in sections:
	    cfg.add_section(s)
	    
	cfg.set("match", "list", "1080 720")
	cfg.set("options", "watch_dir", os.path.expanduser("~/.auto_torrent/to_download"))
	cfg.set("options", "download_program", "python")
	cfg.set("options", "duplicate_detection", "true")
	cfg.set("feeds", "rss", "http://rss.thepiratebay.org/207")
	
	
	
	with open(self.default_config, "w") as config_file:
	    cfg.write(config_file)
	    print "Wrote default config (%s)" % self.default_config
	    
	self.check_download_file()
	
    def check_download_file(self):
	if os.path.exists(self.download_list):
	    return True
	    
	with open(self.download_list, "wb") as n_file:
	    json.dump(["empty"], n_file)
	    print "Initilized download file"


    def already_downloaded(self, t):
        #Function to keep it from unnecessarily iterating.
        for dl in self.downloaded:
            if t == dl:
                return True
        self.downloaded.append(t)
        return False


    def parse_torrent(self, filename):
         #Common things we don't care about
	no_want = ["-", "scenes","xvidhd","brrip",\
		   "bluray", "ac3","a","for", \
		   "of","and","the","torrent",\
		   "tpb","rip","dvd","added",\
		   "1080p", "1080", "720p", "720"]
        
	t_name = []
	
	#Find the common splitter
	for char in list(filename):
	    if char.isalpha() != True and char.isdigit() != True:
		t_name.append(char)
	
	torrent_iter = max(t_name)

	#Format it
        filename = filename.lower().split(torrent_iter)

	#Remove the things we don't want
        for no in set(no_want) & set(filename):
	    filename.remove(no)
		
        return filename

    def compare_filename(self, parsed_torrent):
	#print "Comparing %s" % parsed_torrent
	if self.check_download_file():
	    
	    with open(self.download_list, "rb") as f:
		c = json.load(f)
		for line in c:
		    if len(set(line) & set(parsed_torrent)) > 4:
			print "Duplicate detected (%s)" % parsed_torrent
			return False
	return True
		    
		
    def write_parsed_torrent(self, parsed_torrent):
	#Writes parsed torrent to "download_list", for duplicate detection
	if self.check_download_file():
	    
	    with open(self.download_list, "rb") as prev:
		p_file = json.load(prev)
		p_file.append(parsed_torrent)
	    
	    with open(self.download_list, "wb") as f:
		json.dump(p_file, f)
		return True
		
    def write_torrent(self, to_write, url):
	
	with open("%s/%s" % (self.watch_dir, to_write), "w") as new_torrent:
	    new_torrent.write(urllib2.urlopen(url).read())
	
	print "Wrote",to_write
	
    def get_stuff(self, data):
	print "Sorting..."
        #Sort out all the torrents that we want, and download them.
	print "Using %s to download" % (self.download_program)
        for rel in data:
            t = rel['links'][0]['href']
            if t != "":
                for match in self.matches:
                    if match in t and self.already_downloaded(t) == False:
			
                        to_write = t.split("/")[-1]
			
			parsed_torrent = self.parse_torrent(to_write)
			
			
			
			if os.path.exists("%s/%s" % (self.watch_dir, to_write)):
			    os.rename("%s/%s" % (self.watch_dir, to_write), "%s/%s.added" % (self.watch_dir, to_write))
			    print "Path exists, marking and skipping", to_write
			    continue 
			    
				
			elif os.path.exists("%s/%s.added" % (self.watch_dir, to_write)):
			    print "Already added, skipping", t
			    continue 
				
			
			if self.download_program == "python":
			    if self.detect_dup and self.compare_filename(parsed_torrent):
				self.write_parsed_torrent(parsed_torrent)
				self.write_torrent(to_write, t)
				
			    elif self.detect_dup:
				continue
				
			    else:
				self.write_torrent(to_write, t)
			    
				
			else:
			    print "Using ", self.download_program
			    
			    os.popen("%s %s" % (self.download_program, '"'+t+'"'))
			    if self.detect_dup and self.compare_filename(parsed_torrent):
				self.write_parsed_torrent(parsed_torrent)
			    
			    print "Added ", to_write
			    
	

    def parse_rss(self, feed, tries):
	#Feed parser was a silent bug, it does not always work for some reason, it could be thepiratebay.org though.
	
	print "Parsing %s and duplicate detection = %s" % (feed, self.detect_dup)
	
	while True:
	    parsed = feedparser.parse(feed)['entries']
	    if parsed:
		self.get_stuff(parsed)
		break
	    
    

tpb = ThePirateBay()





