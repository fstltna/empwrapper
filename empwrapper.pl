#!/usr/bin/perl
use strict;
use warnings;

use UI::Dialog;
use Term::ReadKey;
use Term::ANSIScreen qw(cls);
use File::Fetch;

my $EMPIREDIR = "/sbbs/doors/empire";
my $EmpireCommand = "bin/empire";
my $PagerCommand = "/usr/bin/less";


###################################################
# No changes below here
###################################################


my $EMP_ver = "4.4.1";
my $url = 'http://synchronetbbs.org/empusers.txt';

chdir $EMPIREDIR;

# Get file of active users
my $ff = File::Fetch->new(uri => $url);
my $file = $ff->fetch() or die $ff->error;

my $d = new UI::Dialog ( backtitle => "Wolfpack Empire v$EMP_ver", height => 20, width => 65, listheight => 5,
	order => [ 'ascii', 'cdialog', 'xdialog' ]);

my $windowtitle = "Welcome to Wolfpack Empire!";
my $enjoyedtitle = "We hope you enjoyed Wolfpack Empire!";
my $introtext =
"Wolfpack Empire is the classic multiuser game of global conquest. Compete against other players in real-time...";

$d->msgbox( title => $windowtitle, text => $introtext );

if (($d->state() eq "ESC") || ($d->state() eq "CANCEL"))
{
	exit 0;
}

my $menuselection = "";


sub MainMenu
{
	$menuselection = $d->menu( title => "Empire Menu", text => "Select one:",
                            list => [ '1', 'Play Empire',
                                      '2', 'List Sanctuaries',
                                      'q', 'Quit Empire' ] );
}

while (-1)
{
	MainMenu();
	if (($menuselection eq "CANCEL") || ($menuselection eq "ESC") || ($menuselection eq "") || ($menuselection eq "q") || ($menuselection eq "Q"))
	{
		exit 0;
	}
	if ($menuselection eq "1")
	{
		my $clear_screen = cls();
		print $clear_screen;
		system("$EmpireCommand");
		print "--[ Press Enter To Continue ]--";
		my $usrword = <STDIN>;
	}
	elsif ($menuselection eq "2")
	{
		my $clear_screen = cls();
		print $clear_screen;
		open(my $fh, '<:encoding(UTF-8)', $file)
			or die "Could not open file '$file' $!";
		while (my $row = <$fh>)
		{
			chomp $row;
			print "$row\n";
		}
		print "--[ Press Enter To Continue ]--";
		my $usrword = <STDIN>;
	}
}

exit 0;
