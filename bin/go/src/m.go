package main

import (
	flag "github.com/neeee/pflag"
	"github.com/neeee/termbox-go"
	"math/rand"
	"time"
)

var d = flag.DurationP("duration", "d", 0, "sleepy time")

func ch() rune {
	if rand.Int31n(2) == 0 {
		return '╱'
	}
	return '╲'
}

func mod(x int, y int) int {
	if x < 0 {
		return x + y
	}
	return x % y
}

type pair struct{ x, y int }

var dirs = [9]pair{
	{1, 1}, {-1, -1},
	{1, -1}, {-1, 1},
	{1, 0}, {-1, 0},
	{0, 1}, {0, -1},
	{0, 0},
}

type coord struct{ x, y, dir int }

func (c *coord) step(x, y int) {
	c.x += dirs[c.dir].x
	c.y += dirs[c.dir].y
	c.x, c.y = mod(c.x, x), mod(c.y, y)
}

func main() {
	flag.Parse()
	if *d == 0 {
		*d = 1
	}
	termbox.Init()
	defer termbox.Close()
	go func() {
		var c, bc coord
		var change bool
		var color termbox.Attribute
		for {
			change = !change
			if change {
				c.dir = rand.Intn(17)
				color = termbox.Attribute(c.dir)
				c.dir = c.dir % 8
				bc.dir = rand.Intn(9)
			}

			w, h := termbox.Size()
			bc.step(w, h)
			c.step(w, h)

			termbox.SetCell(bc.x, bc.y, ' ',
				termbox.ColorDefault,
				termbox.ColorDefault)

			termbox.SetCell(c.x, c.y, ch(),
				color, termbox.ColorDefault)

			termbox.Flush()
			time.Sleep(*d)
		}
	}()

	for {
		ev := termbox.PollEvent()
		if ev.Ch == 'q' {
			return
		}
	}
}
