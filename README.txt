

	    XBMC Language Filter v1.0 release
	    ---------------------------------
		    by Brock Haymond

Welcome to XBMC Language Filter v1.0 public release!  This version is
compatible with the current version of XBMC, Eden 11.0.  It should
continue to be compatible moving forward with any revision of XBMC,
but is not backwards compatible with older versions.

Visit http://brockhaymond.com for more info about me and my software.


Description
-----------
XBMC Language Filter is a simple perl script creates an edit decision
list, or EDL file, from a subtitles file.  The script can accept any 
given subtitle (SRT) file or a directory of SRT files.  The output is 
an EDL file (or files) that matches the name of the original subtitle
supplied, placed in the same location as the original subtitle file.

The XBMC "MPlayer" EDL file structure that this script outputs is:

[starting time]		[ending time]		[action]
443.78     		445.39     		1

The action to take is "1" for mute.  The "MPlayer" file structure is 
further explained here, along with other supported actions (such as 
removing a scene completely):

http://wiki.xbmc.org/index.php?title=Edit_decision_list#MPlayer_EDL  


How to Use
----------
1.  Make sure your subtitle file and your movie are exactly IN SYNC.
This means that when your subtitles show text, that text is being spoken
at the exact same time.  If this is not the case, XBMC will not be in
sync to mute profanity at the right times during the movie.

2.  Run XBMC Language Filter and supply the subtitle file for the movie 
you desire to edit.  For Linux, this is by command line only.  An EDL 
file will be produced in the same location as the supplied subtitle file.

3.  Move the EDL file that XBMC Language Filter produced into the same 
directory as the movie.

4.  Make sure that the EDL file and movie have to have the exact same
name.  If they do not have the SAME NAME and are located in the SAME
DIRECTORY, XBMC will not find the EDL file when the movie is played 
and it will not be edited.

5.  Enjoy your movie edited!


Caution
_______
This project is aimed at editing profanity from movies.  For this 
purpose lists of profane words have been enumerated in files in order
to define search criteria.  Viewer discretion is advised to these lists
and should be limited to "must see" only.


Problems?
_________
If you run into any profanities that XBMC Language Filter isn't
detecting, or for any other problems please email me or submit a bug
report on github!

slowfoxtrotdesign@gmail.com
https://github.com/Slowfoxtrot/XBMC-Language-Filter

One known issue is if the subtitle is in UTF-16 encoding the
EDL file will be empty when created.  You will need to open the
subtitle file and save it as UTF-8 and then resubmit it to the
filter.

Enjoy!

Brock Haymond
Slowfoxtrot Design