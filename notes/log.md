# Intent

The goal of this project is to run a machine learning project.

In Python 1.

On a NEXT computer. (Or near enough.)


## Why?

No particular reason, but a few things that come to mind:

* personal curiosity - I enjoy exploring my sense of nostalgia. And I've always wanted to work on a NEXT computer.
* personal challenge - I think this sits right in the borderline of possible, but for no particular good reason. It's the kind of slightly nuts thing where I can't see a reason why I shouldn't, so my brain says it's probably going to happen.
* internet cred!
* mechanical sympathy - I would like to appreciate what was once available!

# Technical approach

## Previous emulator

The main emulation approach is `Previous`. Cute!

### Installation for ubuntu

Looks pretty abandonded , but we can make it work. Maybe.

23/11 - I adapt the install script from the [website](http://previous.alternative-system.com/index.php/build). I'm running Ubuntu 16; it doesn't look like it's really particularly designed for this and hasn't been updated in a long time; we can only hope that it works.
- build is progressing... no errors so far...
- stay on target...
- reminded of the xkcd comic... my code's compiling...
- I wish I knew more about C. I should probably look into that one of these days.
- build has executed ... let's check
- Successful launch!! Surprisingly smooth.

#### Digging further

Looks like this is surprisingly advanced - the readmes suggest I can actually get Previous to talk to my network (!) including instructions on how to spin up a fileserver on a Mac and connect Previous to it (!). Some technologies are pretty solid, it seems.

## Images

### Approach 1 - compile and build our NextStep image from scratch


#### Floppy approach

we now pull an image from [here](http://www.shawcomputing.net/resources/next/hardware/boot_floppies/boot_floppies.html). We'll dump the image.

The image is not as simple as I had quite expected. This floppies that are provided are the legit boot floppies - the README is signed 'Mike, 2/26/1991'. Really reaching across the ages here.

Reading the readmes indicates that is a very barebones image as well - not quite what I was hoping for.
 
#### Forum investigation

Based on what [this forum](http://www.nextcomputers.org/forums/index.php?topic=4254.0) indicates, the emulator may not actually be close enough to do an install from scratch. 

It appears there's also a lot of useful information [here](https://forum.winworldpc.com/discussion/6503/how-to-emulate-nextstep-in-previous-or-other-emulator). 

I've sourced an image; now to dig further into how to actually use it.

##### Image creation

We'll have to spin up a blank hard disk image. 

https://askubuntu.com/questions/667291/create-blank-disk-image-for-file-storage
http://www.nextcomputers.org/forums/index.php?topic=4504.0

A very thorough example is provided.


We'll drop this in an easily accessible folder.

#### User manual

https://forum.winworldpc.com/discussion/6503/how-to-emulate-nextstep-in-previous-or-other-emulator

This could be of use.

Update - it was!

### Approach 2 - just find a pre-built image

While the above was likely going to yield results, I found this pre-built image:

https://winworldpc.com/product/nextstep/3x

On reviewing the documentation, all I had to do was mount the drive and away we go. 

(This also gives me confirmation for what I was doing previously - in other steps I would be creating a blank image, mount it, step through the boot process with floppies to set up the HDD with an image. Here we just side-step and jump to the end.)

Too ez.

# In next step!

I'm in!

Hell yes! Colour nextstep is mine.

## Exploring next step

Nextstep is to Mac like middle english is to modern. It's all there, it's extremely fascinating. 




## Next steps (pardon the pun)

The new priorities:

* I've identified a pre-compiled GCC compiler. That might help side-step some issues with compiling GCC for a new architecture.
    https://www.savarese.org/patches/gcc.html
* The challenge is passing files back and forth. The best and easiest way to move forward might be to set up a file share, which appears to be possible.
There'll be some steps involved, but won't be impossible I imagine.


----

# Session 2

## File sharing

The problem that emerged once the emulator was up and running was file transfer. There are actually a surprising number of options available:

* Integrate a fake disk drive, mount it in Ubuntu and write the relevant files to it; and then mount it to the NeXTSTep instance. I did explore this, more out of curiosity and learn about devices, mounts, and images than as a practical process of passing files back and forth. The result seems to be that this *is* a feasible approach, but is not without challenges. 
    * The main challenge is file systems and partitioninig - things have changed between 1994 and 2020, particularly around standards and defaults! NeXT is as fully featured as you would expect, and is happy to format a blank disk presented to it; but mounting the consequently formatted disk in Linux can be painful because the auto-file-system-detection doesn't really seem to be designed to pick up whatever NeXT lays down. I think by exploring more options in NeXT we could sort this out, but it's not really a focus, so I'll leave this for now.
* I could certainly write file contents to `.iso` and load them up as CDs within NeXT. All things considered, this is a process that I was happy to leave in the late '00s, and I don't really want to go back to it.
* Interestingly, the Previous emulator came with information on how to set up networking and filesharing with an external machine Mac OS X (!). That's the ideal solution I think - read-write on both sides.

### NFS filesharing with Linux

So, the instructions that came with Previous explain how to set up NFS with Mac OS X. I do have a Mac; there's no reason why I couldn't use that; but it certainly made sense to me that I should be able to set up a NFS server on my Linux machine which is *running*. 

After a few hours of configuring NFS server options on my Linux machines, combing through the NeXTStep forums hoping for solutions to my problem. I went down a few pathways (was it the NFS firewall? Was it something on the Previous emulation?) but nothing quite worked. I *think* it should still be possible; I think perhaps the issue is around connecting a NFS client to a NFS server running on the same IP address; add in a layer of emulation and 25 years of age difference and you have a challenging problem to debug. (Or maybe it's not; frankly I don't have a lot of experience in this space.)

### NFS filesharing with Mac

Anyway, I followed the 3 shell commands recommended for the Mac OS X solution and it was up and running almost instantly. So go figure.

## Installation of GCC

Files were downloaded to the Mac and transferred across using the NFS setup; it's wildly slow, but functional.

## Installation of Python

In theory, we should just have to copy the files across and run `./configure` and `make`. But practically let's see what happens.

The readme includes a lot of information on compiling for different architectures, including for NeXT. If I configure with `--with-next-archs` during the configure process, we should be okay.

We'll run `./configure`; then `make`; and then we see what happens.

### Troubleshooting!

We're issues - there's not an assembler installed.

This may be of use: 

http://geoweb.mit.edu/~simon/gcc_g77_install/specific.html#m68k-*-nextstep*

Exploreing a few options leads us to find that we're missing most of the basic development tools by default. There's no assembler, linker, or include files installed at all.

### Developer ISOs

The developer ISOs are available here: https://archive.org/details/nextstep3-3dev

We can mount this with Previous and get to installing the relevant files. Interestingly, this is handled with the Install Manager which is remarkably similar to the current MacOS system, and installs promptly and without fuss.

It's also worth noting that this software originally retailed for a cool USD$4,999 in 1995 or so, or around $8,626. Thanks, archive.
https://www.blackholeinc.com/catalog/software/Software/NeXT/NEXTSTEPDeveloper.shtml

When this is all installed, we find that there is a properly set up `cc` and `as` utility available in our shell and we can give compilation a red hot go.

### Attempting to install Python

#### Issues with the Include files

So, we settle back into the process and run the compilation process. Things work *surprisingly* smoothly for a period of time, only for the installation process to eventually bog down when compiling the `Modules` section of Python. 

I'm not terribly familiar with C compilation, so I'm really coming up the learning cliff on this one. So I start taking a bit of a dive.

For example, something's bombing out in the `_locales` module. The code is making a call to `strcoll` and is crapping out, saying that there's not enough arguments. That feels like a pretty blatant oversight for the Python codebase, so I take a look.

In the Python codebase, I can confirm that there's a call to `strcoll` with two arguments, `s1` and `s2` or something along those lines. The call in `_localemodule.c` is perfectly normal - textbook, really! - with a call to `strcoll(s1, s2)` - this is almost exactly what you see when you look up any implementation of `strcoll` online:

http://www.cplusplus.com/reference/cstring/strcoll/

This appears to be a pretty standard part of the C standard library, and it's not clear why it's bombing. 

So I dig into `string.h` in the provided NeXTstep code, and it's... odd? The function has a totally different signature:

`int strcoll(char *to, size_t maxsize, const char *from)`. 

That `size_t maxsize` seems to come out of nowwhere and is totally borking up the implemetnation.

This seems to be a really uncommon implementation - the only example I can find is in a book "Software Engineering in C", which notes that it "documents the proposed ANSI standard C, which is expected to be ratified in 1987":  https://books.google.com.au/books?id=NGkECAAAQBAJ&lpg=PA467&ots=9PyBkAKke1&dq=strcoll(to%2C%20maxsize%2C%20from)&pg=PA467#v=onepage&q=strcoll(to,%20maxsize,%20from)&f=false

Clearly something's a little awry here. I'm keen to learn about what the hecky is actually going on, but it is that way sometimes. I'd be keen to get someone's perspective on this one, and whether this actually the ANSI C implementation, or just something spicy and specific to NeXT, or what. Further reading goes down the line to recognise that there's a lot to pull apart in this space.

#### A hacky workaround

Thinking that there might be some good solutions in the README, I go back and visit it in the root of the package. I don't see much around hints for NeXT compilation - the only notes added specific to this environment are focused on building "fat binaries" (another fun term to Google). 

But reading above, I note there is a message for SunOS 4.x (first released 1988, it should be noted): 

> When using the standard "cc" compiler, certain modules may not be compilable because they use non-K&R syntax. You should be able to get a basic Python interpreter by commenting out such modules in the Modules/Setup file, but I really recommend using gcc.

Hmm, hell yeah. That seems like it might work.

Sure enough, I jump into `Modules/Setup` and begin commenting out the troublesome modules as they crop up during compilation. (Interestingly, it seems there's a lot of intended variation in what modules to install, based on the notes within this file.) 

Slowly but surely I make progress until it is complete: the `make` process runs to completion and I am granted a single execution `python` file. I run it and I am greeted with the beautiful sight of a Python interpreter. A (hopefully minor) on execution, but functional nonetheless, and with a new compilation message I've never seen.

`[GCC NeXT DevKit-based CPP 3.1] on next3_3`

I'd like to think that's a compilation message that isn't seen every day.

# Python Machine Learning

## Setting up the environment

Overall, I think I'm pretty confident on where to go next for this project. I have a couple of goals:

* Perform some basic machine learning on a simple dataset using Python 1.6, with scripts developed in the NeXT environment.

## Development

Overall, it's pretty chill. I pop open a couple of terminal windows and get going.

I create a project structure - `/data` and `/scripts` and a `readme`, not much more than that required. 

As I start working on the dataset manipulation process, there are some fun learnings:

* I miss the `csv` module
* there are some utility `fileinput` modules, that's pretty neat
* there's no `import XXX as YYY` functionality, which is kind of bizarre

But overall this is a pretty standard development if basic. I miss syntax highlighting and some of the functionality out of `vim` (versus `vi`) but overall it's pretty chill.

One this I will note is that the performance is notably a bit slower, especially on read/write. Normally when I write Python scripts, I skew towards the 'readability' spectrum even at a slight cost of performance (after all, we're using Python to begin with! The entire language is based on this principle.); in a modern environment most 'trade-offs' are minute;  on this machine, this cost trade-off feels significant.


----


mounting

```bash
losetup -f  # find next loop device, e.g. /dev/loop13
sudo losetup /dev/loop13 NS33_2GB_dup.dd  # assign to loop
sudo mount -t ufs -o ufstype=nextstep /dev/loop13 /mnt/next 
# https://unix.stackexchange.com/questions/316401/how-to-mount-a-disk-image-from-the-command-line
# https://www.kernel.org/doc/html/latest/admin-guide/ufs.html
```