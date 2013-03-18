.TL
Circuit Design Aids (CDA) on Plan 9
.AU
A. G. Hume
.AU
M. Kahrs
.AU
T. J. Killian
.AB
.CW CDA
.NL
is a system for the design and prototyping of digital systems.
At the front end
it provides hierarchical schematic entry,
programmable logic device
design and board layout; at the back end it
produces data for various manufacturing technologies, in particular
wire-wrap and multiwire.
.AE
.NH
Introduction.
.LP
.CW CDA
is a design system, i.e., a collection of programs and data formats
dating back almost 15 years.  It has progressed with the accompanying changes
in display, computing and device technology.  To the
.CW CDA
user, 
A hardware design has a logical part and a physical part.
The logical part consists of circuit schematics, generally
supplemented by boolean equations together with finite state machines
and programs in ROMs.
The physical part includes board layout and wire routing.
.LP
.CW CDA
has its own terminology; a circuit contains
.I chips
each identified by a
.I name
(which is arbitrary, and of mnemonic value to the designer) and a
.I type
(which is generic, e.g.,
.CW 74LS74 ")."
Schematics can be hierarchical; what appears syntactically as
a chip can, in fact, be an instance of a parameterless
.I macro ,
(i.e., another drawing) if the file
.I "type\c"
.CW ".w"
.R
exists.
Real chips have
.I pins ,
each identified by a
.I "pin name"
and
.I "pin number" ","
and a
.I "package type" "."
Pin names and their mapping onto pin numbers are a property of
the chip type; the mapping from pin numbers to physical coordinates
is a property of the package type.
.LP
Pins are connected by
.I nets ","
which have unique
.I "net names"
(assigned by the drawing to net conversion program if
omitted by the user).  It is an error for a pin to
be connected to more than one net.
Nets such as
.CW VCC
and
.CW GND
generally need different routing algorithms from ordinary nets;
these are called
.I "special-signal nets"
in cases where the distinction is important.
.LP
A
.I board
is a physical mounting for packages.  It is mostly characterized by its
.I "pin holes"
(available for package insertion) and
.I "special-signal pins"
(connected to special-signal nets).  An
.I
.CW I/O
.R
.I connector ","
where signals enter or leave the board, is simply a special case
of a chip.
.LP
The manual pages for the
.CW CDA
commands and file formats are in section 10 of the manual.
.NH
Methodology.
.LP
These are the conventional steps in a design.  Many are necessary simply to
maintain consistency between ``source'' and ``object'' files.
We will collect all of this into a
.CW mkfile
in a later section.
.nr P 0 1
.IP (\n+P)
The interactive program
.I graw
is used to construct schematics (kept in files
whose names end with
.CW ".g" ".)"
The net list of a circuit diagram (its
.CW ".w"
file) are derived from the
.CW ".g"
file by running
.I "gnet" "."
.IP (\n+P)
Any editor may be used to create files in
.CW lde
format for logic that is to be implemented with Programmable Array Logic
.CW "(PAL)" "'s."
These filenames end with
.CW ".lde" "."
Pin information resides in a corresponding
.CW ".p"
file, generated by
.I "part"
which is a member of the
.I part
family of programs.
.IP (\n+P)
A
.CW ".pins"
file, that matches pin names with numbers for each chip type, must
be constructed.  Most pin information comes from standard libraries,
but the user must generally supply some of it, usually for
.CW I/O
connectors (\c
.CW io.pins ")"
or non-standard chips (\c
.CW my.pins ")."
.I Mkpins
reads
.CW ".w"
files,
.CW ".p"
files, and pin libraries to produce the
.CW ".pins"
file.  The principal advantage of using
.I mkpins
is to reduce the size of the pins file and thereby speeding up the time
spent in
.I cdmglob.
.IP (\n+P)
.I "Cdmglob -f -v"
reads the
.CW ".w"
and
.CW ".pins"
files to produce a
.CW ".wx"
file, in which all macros are expanded, and nets are described in terms of
pin numbers.  The
.CW -v
flag tells
.I cdmglob
to include the name of the expanded pins in the output.  This will be used in the
final stages by
.I annotate
to create a
.CW ".a"
file containing just the pin numbers (in
.I graw
format).  This file, when "catted" with a
.CW ".g"
file will label all the pins with pin numbers.
.IP (\n+P)
At this point one may do static circuit checks with
.I smoke "."
The errors will be rather voluminous until all pins are declared correctly on the
.CW ".tt"
lines.  Some errors are impossible to eradicate, particularly those with a mix of
analog and digital components.
.IP (\n+P)
Most files discussed so far have to do with the logical part of the design, and,
except for
.CW ".lde"
files, are in
.CW CDL
(Circuit Design Language).  The remainder of the physical design files are in
.CW FIZZ
format.  So, at this point, one uses
.I "fizz cvt"
to turn the
.CW ".wx"
file from
.I cdmglob
into a 
.CW FIZZ
.CW ".fx"
file.
.IP (\n+P)
As with the
.CW ".pins"
file, one creates a
.CW ".pkg"
file with geometric descriptions of each package type.
.IP (\n+P)
A geometric description of the board (\c
.CW ".brd"
or
.CW ".board"
file) in
.CW FIZZ
format is made (or stolen from
.CW /sys/lib/cda/boards ")."
.IP (\n+P)
Chip positioning information (\c
.CW ".pos"
file) is generated.  This is usually done interactively with
.I "place" "."
.IP (\n+P)
At this point, the design should be checked with
.I "check" "."
This will find any errors that might result from unplaced chips or overlapping
packages and so forth.
.IP (\n+P)
The wrap list (\c
.CW ".wr"
file) is now made, and one can physically wrap the board, typically by using
a semiautomatic machine.
.IP (\n+P)
To make changes, one generates a new
.CW ".wr"
file;
.I rework
then compares the new and old wrap files and generates separate lists
for unwrapping and rewrapping.
.NH
Graphics input
.LP
The graphics editor
.I graw
is used to create and modify drawings, a.k.a. schematics.  A drawing consists of
.I "chips, macros,"
and
.I signals
connected by
.I pins.
Each chip has a
.I name
and a
.I type.
Pins can have either a
.I name
or a
.I number.
.NH 2
Using graw
.LP
The editor,
.I graw
can be given a list of files ending in
.I ".g."
or an empty list.  When
.I cda
starts, the cursor changes to a \(mu.  Button 1 performs two tasks: a single
click locates the cursor; when dragged with the button held down,
the mouse leaves behind a line.  Button 2 presents a list of useful options:
.CW onesies\(->
can be used to select either
.CW box
which then can be used to sweep out the rectangle of a box using button 1,
or
.CW macros
which can also sweep out a box using button 1.
.LP
.CW inst\(->
selects a master to be instantiated and attached to the cursor until any button
is pressed.
.I graw
doesn't have any masters when loaded initially.  The standard library of gates
can be read by using the
.CW read
command.
.CW sweep
uses a rectangle input with button 1 to grab a set of objects and drag
them until any button is pressed.
.LP
.CW slash
differs from
.CW sweep
only in that rectilinear lines are first cut by the input rectangle.
.LP
.CW cut
undraws and moves the object(s) last drawn or moved to the cut/paste buffer.
.CW paste
attaches a copy of the cut/paste buffer to the cursor until any button is
pressed.
.LP
.CW snarf
is a
.CW cut
without the undraw.
.LP
.CW scroll
attaches the entire drawing to the cursor until any button is pressed.
.LP
The button 3 menu entries are
.CW "edit, read, write, exit,"
and
.CW new,
followed by the list of filenames currently being edited.
.LP
.CW edit
prompts for a file name and reads in the file for editing.  Backspace and
control-W may be used to edit the name; a null file name aborts the operation.
.CW read
prompts for the name of a master file, reads it in, and plants a reference to
it in the current file.  The names of the masters in the file are added to
those in the
.CW inst\(->
menu for the current file, overwriting older definitions if necessary.
.CW write
prompts for a file name (starting with the current file name).  The non-null
result becomes the new file name and the file is written.
.CW exit
terminates the program.  You must type a `y' to really exit.
.CW new
creates a new, unnamed drawing for editing.
.PP
Selecting a file name selects the current file.
.NH
Signal Bundles and Macros.
.LP
Consider this buffer between two 8-bit busses:
.PS <fig1.pic
It illustrates several
.I graw
conventions.  The
.I chip
is indicated by a box; its
.I name
is
.CW buffer ;
its
.I type
is
.CW 74F244 .
These are simply unattached text strings that appear stacked inside the
box.
.I "Pin names"
(e.g.,
.CW D0 )
are strings that appear on the inside edge of the box.
.I Nets
are lines that end on a pin.
.I "Net names"
are strings that are placed on nets.  A trailing
.CW "-"
conventionally indicates an active-low signal.
.LP
Even this trivial example involves repeated patterns.
A much more succinct equivalent is:
.PS <fig2.pic
The
.I generator
.CW "x<0:7>"
expands into the ordered list
.CW x0 ,
.CW x1 ,...
.CW x7 .
The
.I pattern
.CW "D?\&"
matches two-character pin names that begin with
.CW D .
(The space of possible names comes from the
.CW .pins
file entry for the chip type.)
The names that match the pattern are
.I "sorted alphabetically"
and put into correspondence with the nets.
.LP
If connected sets of nets and pins do not have the same cardinality,
the smaller set is reused until the larger is exhausted.  Thus in the
example, the
.CW drive-
net gets connected to both
.CW OE0-
and
.CW OE1- ,
as desired.
.LP
Another example of the same buffer is shown below:
.PS < fig3.pic
Note that since the buffer symbol is too small to hold the name of the chip, the
name and type are "connected" to the instance via a wire.  The wire is \fInot\fP
considered a net by \fIgnet\fP.  Also notice that the range <0:7> after the name
of the chip is appended to the pin names.  In fact, this buffer has invisible pin
names of
.CW D
and
.CW Y .
(input and output respectively).
Thus, after appending the range, \fIgnet\fP will generate
.CW D<0:7>
and
.CW Y<0:7> .
Since the output enable can't fit, the output enables are put in another, smaller box.
.LP
Frequently one has a group of chips that will be used or replicated as
a unit.  In such a case it makes sense to define a
.I macro
that may be instantiated as required.  A macro lives in its own file.
Here is an example,
.CW opm.j :
.PS <opm.pic
The dotted box (produced by sweeping out a
.CW macro
box in
.I graw ")"
identifies the circuit as a macro.  Strings outside of this box
(conventionally in upper case) are ``pin names'' visible to the
outside world.  Most names inside the box will be made local to
each instantiation.  Net names beginning with
.CW "/"
are ``globals,'' i.e., they represent the same signal throughout
the design.
.CW "/VCC"
and
.CW "/GND"
are the most common global signals.  These signals are expanded by
.I cdmglob
to be ``<instance>//VCC'' and ``<instance>//GND'' respectively.  A
.I sed
script can be used to rid the net list of the file name prefixes:
.CW /\\/\\//s/	.*\\/\\//	/ s/	\\//	/
.LP
Now we use generators to make several instances of
.CW opm.j :
.PS <opmcall.pic
Sixteen copies of the
.CW opm
circuit are made.  The pattern
.CW "D?\&"
is at a lower, i.e., ``faster running,'' level than
.CW "opm<00:15>" ,
with the effect that all the
.CW D0 "'s"
are connected to
.CW "bd0" ,
all the
.CW D1 "'s"
are connected to
.CW "bd1" ,
etc; similarly, all the
.CW A0 "'s"
are connected to
.CW ba0 .
On the other hand, all the
.CW "CS-" "'s"
are separate:
.CW "opm00/CS-"
(the instance of
.CW CS-
in
.CW opm00 )
is connected to
.CW "ops00-" ,
.CW "opm01/CS-"
is connected to
.CW "ops01-" ,
etc.  The manual entry for
.I cdmglob
should be consulted for all the details.
.NH
A Toy Example.
.LP
In this section we present a complete example.  The design consists of
two
.CW I/O
connectors that route signals from a ribbon cable to a backplane.
Here is the schematic, followed by the
.CW ".w"
file:
.PS <toy.pic
.nr dP 2	\" delta point size for program
.nr dV 2p	\" delta vertical for programs
.LD
.so toy.w.l
.DE
.LP
The comments (introduced by
.CW % )
are coordinates from the
.CW .g
file that can be used later to annotate the drawing with pin numbers.
Otherwise the
.CW .w
file is mostly just a compendium of the text strings in the
.CW .g
file.
In order to proceed further, we need a
.CW .pins
file:
.LD
.so toy.pins.l
.DE
.LP
It should be fairly obvious what is going on here.  Note the appearance of the
.I "package type"
following the type name on the
.CW .t
line.
.LP
For some parts, constructing a
.CW ".tt"
line will be an onerous task (typical examples are parts with
.CW PGA
pinouts).  For these parts, the use of
.I pga
is recommended.  It accepts a list of pin names and pin types (one per line) and
produces a suitable part definition.  The manual page has all the details.
.PP
Now the
.CW .wx
file can be made with
.CW "cdmglob -v -f"
to get:
.LD
.so toy.wx.l
.DE
.LP
This is basically a listing, for each chip, of net\ name\-pin\ number pairs.
Package types are copied through from the
.CW .pins
file for use by the physical design tools, and
the expanded pin names are left as an aid to humans and
.I annotate.
.PP
At this stage, physical layout can begin.  The first step is the conversion of the
.CW ".wx"
file into a
.CW FIZZ
.CW ".fx"
file via
.I cvt "."
The result is shown below:
.ps 8
.LD
.so toy.fx.l
.DE
.R
.TE
.PP
Next, a board file is selected.  Since this is a simple example, a simple board
like a Schroff 3U board can be used.  Here's the definition of the Schroff board:
.LD
.so schroff.board.l
.DE
To fully understand this definition, a careful reading of the
.CW FIZZ
format manual page is advised.  Briefly, the align is used with the semi-automatic
wirewrap machine.  The pinholes locate pins \- the letter
.CW A
denotes a drill type (ignored here but still required).  The final two
.CW Vsig
declarations specify the special signals.
Given a board and the
.CW ".fx"
file,
.I "place"
can be used to place these two connectors
.CW "BERG40"
and
.CW "DIN96RX" "."
The result is a
.CW ".pos"
file like this:
.LD
\&Positions{
\&	plane 1200/1100 0 0
\&	cable 6600/1800 1 16
\&}
.DE
.LP
.I "Check"
should be run on these files
.CW .board , (
.CW .fx ,
.CW .pos )
and any errors should be resolved before proceeding.
%.I Plot
%generates a picture of the board:
%.so toy.draw.r
%.R
%Note how the alignment marks are shown.  Pin 1 of each package is illustrated by
%two concentric circles around the pins.
Now a wrap file (with extension
.CW ".wr" ")"
suitable for driving the semi-automatic wire-wrap machine can be created with
.I "wrap -cv" "."
The use of Multiwire technology needs some hand holding \- but we don't know who they
are anymore.  You can try calling Hitachi Chemical.
.NH 2
PCB layout
.PP
.CW CDA
was mostly designed with the wirewrap environment in mind.  With the emergence of
surtface mount technology, wire wrap is almost gone.  However, CDA can now interface with the
.CW pcb
editor available through the GEDA project.  The steps are as follows:
First, take the .wx file and convert it into a .net file via the -P -N option of fizz cvt.
Second, take the .wx file again and extract the PCB footprints via fizz cvt -P and
the use of the "topcb" script.
Third, start up pcb and set the parameters (such as the board size) via the preferences menu.
Write out the layout as "preamble.pcb".
Lastly, cat preamble.pcb with the extracted footprints.  Store this as a .pcb file.  Now,
start pcb with this file.  Load in the netlist.  And you should be ready to place and then
let the autorouter have its way.
.NH 1
Debugging and rework
.LP
Debugging a circuit is beyond the scope of this paper, but
.CW CDA
does provide support for altering a wirewrap board.
.LP
The scenario is that you have a board that corresponds to a wraplist
.CW v1.wr .
After making the necessary changes to your schematics and or logic
equations, a new wraplist
.CW v2.wr
is generated.
You then run the command
.CW cda/rework v1.wr v2.wr
which generates three files.
The first file,
.CW UN.wr ,
contains a wraplist of the wires to take off (remove).
The second file,
.CW RE.wr ,
contains a wraplist of the wires to add.
The third file,
.CW NEW.wr ,
is a wraplist that is electrically equivalent to
.CW v2.wr
but represents the wirewraps on the board
(that is, if you wrapped a board with
.CW NEW.wr
you would get an identical board).
After doing the unwrapping and rewrapping,
you should treat
.CW NEW.wr
as your actual
.CW v2.wr .
.NH 1
Analog design
.PP
In spite of the fact that
.CW CDA
was created for the design of digital circuits, it can also be utilized for
analog circuits as well.  A separate library of analog shapes located in
.CW /lib/graw/analog.g .
These shapes follow the following naming convention:  the shape name begins with
an orientation, a underscore, and then the name of the shape. This is because
.CW graw
doesn't have rotation or reflection operations (yet).  The characters
denote:
.TS
center;
l l.
character	orientation
_
h	horizontal
v	vertical
l	left
r	right
t	top
b	bottom
.TE
For example, an electrolytic capacitor with the positive terminal is called
"t_ecap".  An NPN transistor with the emitter on the bottom left would be "bl_npn".
Analog design is facilitated by the famous
.CW -k
option to
.CW gnet .
This option eliminates the need to draw lines to each component.  The only problem
is figuring out the best location for the part name.  Only experience will help
you.