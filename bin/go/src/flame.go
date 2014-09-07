package main

import (
	"math/rand"
	"time"

	flag "github.com/neeee/pflag"
	"github.com/neeee/termbox-go"
)

const bg = termbox.ColorDefault

var (
	in = flag.IntP("intensity", "i", 65,
		"intensity on randomly chosen spots at the bottom")
	d = flag.DurationP("delay", "d",
		time.Millisecond*30, "set lower to go faster")
	dim = flag.Bool("dim", false, "don't use bold")
)

var timeoutc = make(chan struct{})

func ticker(ch chan struct{}) {
	for {
		time.Sleep(*d)
		ch <- struct{}{}
	}
}

func min(x, y int) int {
	if x > y {
		return y
	}
	return x
}

func max(x, y int) int {
	if x < y {
		return y
	}
	return x
}

func fire() {
	char := [...]rune{' ', '·', ':', '~', '*', 'x', 's', 'S', '#', '$'}
	var oldSize int
	var b []int

	for {
		w, h := termbox.Size()
		size := w * h
		// resize on resize
		if oldSize != size {
			b = make([]int, size+w+1)
			oldSize = size
		}
		// plant fire
		for i := 0; i < w/9; i++ {
			n := *in
			if r := rand.Intn(60); r == 1 {
				n = n + rand.Intn(n*5)
			} else if r == 2 {
				n = rand.Intn(n * 5)
			} else if r == 3 {
				n = rand.Intn(n)
			} else if r > 5 && r < 10 {
				n = rand.Intn(n / 5)
			}
			b[rand.Intn(w)+w*(h-1)] = n
		}
		// degrade/spread fire
		dir := 0
		for i := 0; i < size; i++ {
			// TODO: make this cleaner
			switch dir {
			case 0:
				b[i] = (b[i] + b[i+1] + b[i+w] + b[i+w+1]) / 4
			case 1:
				b[i] = (b[i] + b[i-1] + b[i+w] + b[i+w-1]) / 4
			case 2:
				b[i] = (b[i] + b[i+1] + b[i+w] + b[i+w-1] + b[i+w+1]) / 5
			case 3:
				b[i] = (b[i] + b[i-1] + b[i+w] + b[i+w-1] + b[i+w+1]) / 5
			case 4:
				b[i] = (b[i] + b[i-1] + b[i+1] + b[i+w] + b[i+w-1] + b[i+w+1]) / 6
			}
			if rand.Intn(10) == 1 {
				dir = rand.Intn(5)
			}
			var color termbox.Attribute
			switch {
			case b[i] > 20:
				color = termbox.ColorBlue
			case b[i] > 15:
				color = termbox.ColorWhite
			case b[i] > 9:
				color = termbox.ColorYellow
			case b[i] > 4:
				color = termbox.ColorRed
			default:
				color = termbox.ColorBlack
			}
			if !*dim {
				color = color | termbox.AttrBold
			}
			if i < size {
				termbox.SetCell(i%w, i/w,
					char[min(b[i], len(char)-1)],
					color, bg)
			}
		}
		termbox.Flush()
		<-timeoutc
	}
}

func main() {
	flag.Parse()
	termbox.Init()
	go fire()
	go ticker(timeoutc)
	// wait for any event
	for {
		ev := termbox.PollEvent()
		if ev.Ch == 'q' {
			break
		}
	}
	termbox.Close()
	return
}
