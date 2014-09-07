package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/neeee/golib/mpdh"
	"github.com/neeee/rwidth"
)

var wc = flag.Bool("w", false, "Set if widechars are 2x width")

func slen(s string) (l int) {
	for _, r := range s {
		w := rwidth.Width(r)
		if *wc {
			l += w
		} else if w == 2 {
			l++
		} else {
			l += w
		}
	}
	return l
}

func errh(err error) {
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func or(sa ...string) string {
	for _, s := range sa {
		if s != "" {
			return s
		}
	}
	return ""
}

func showTime(ls string) string {
	f, _ := strconv.ParseFloat(ls, 64)
	l := int(f)
	hours := l / 3600
	l -= hours * 3600
	minutes := l / 60
	l -= minutes * 60
	seconds := l

	if hours > 0 {
		return fmt.Sprintf("%d:%02d:%02d", hours, minutes, seconds)
	}
	return fmt.Sprintf("%d:%02d", minutes, seconds)
}

func main() {
	flag.Parse()
	c, err := mpdh.InitFromFlags()
	errh(err)
	song, err := c.CurrentSong()
	errh(err)
	status, err := c.Status()
	errh(err)
	errh(c.Close())
	var (
		title  = or(song["Title"], filepath.Base(song["file"]))
		artist = song["Artist"]
		album  = song["Album"]
		date   = song["Date"]
		time   = showTime(song["Time"])
	)
	if l := status["elapsed"]; l != "" {
		time = showTime(l) + "/" + time
	}

	max := slen(title) - slen("Artist  ")
	for _, s := range []string{artist, album, date, time} {
		if l := slen(s); l > max {
			max = l
		}
	}
	pad := func(s string) string {
		l := slen(s)
		if l >= max {
			return s
		}
		return strings.Repeat(" ", max-l) + s
	}
	fmt.Printf("%s\n\n"+
		"Artist  %s\n"+
		"Album   %s\n"+
		"Date    %s\n"+
		"Time    %s",
		title, pad(artist), pad(album), pad(date), pad(time))
}
