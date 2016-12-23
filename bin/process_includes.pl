#!/usr/bin/env perl
#
# Reprocess includes for title bars and menus in OAI website
#
# Simeon Warner - 2016-12-14 (to replace old php)
#
use strict;

my @files=(
'index.html',
'documents/index.html',
'pmh/index.html',
'pmh/tools/index.html',
'ore/index.html',
'ore/documents/index.html',
'ore/community/index.html',
'organization/index.html',
'news/index.html',
'news/news2.html',
    );

foreach my $file (@files) {
    process_file($file);
}

sub process_file {
    my ($file)=@_;
    print "Processing $file...\n";
    my $infh;
    my $outfh;
    my $outfile=$file.'~';
    unless (open($infh, '<', $file)) {
	die "Failed to open $file for reading: $!";
    }
    unless (open($outfh, '>', $outfile)) {
	die "Failed to open $outfile for writing: $!";
    }
    my $title=undef;
    while (my $line=<$infh>) {
	if ($line=~m%<title>(.*)</title>%) {
	    $title=$1;
	    print "  title = $title\n";
        } elsif ($line=~m%<!--START-TITLE-->%) {
	    # Read to end
	    my $chunk='';
	    my $chunk_line;
	    while ($chunk_line=<$infh> and
		   $chunk_line!~m%<!--END-TITLE-->%) {
		$chunk.=$chunk_line;
            }
	    $line .= title_html($title)."<!--END-TITLE-->\n";
        }
	print {$outfh} $line;
    }
    close($infh);
    close($outfh);
    # Did we make any changes?
    my $diff = `diff $file $outfile`;
    if ($diff) {
	print "  diff\n$diff";
	print "\nAccept changes [y|N]?";
	my $in=<STDIN>;
	if ($in=~/^y/i) {
	    rename($outfile,$file);
	} else {
	    print "  change rejected\n";
        }
    } else {
	print "  no change\n";
    }
    unlink($outfile) if (-e $outfile);
}

sub title_html {
    my ($title)=@_;
    
    $title =~ s%(Open Archives Initiative)(\s+-\s+|:\s+|\s+)%\1<br />%;  # add line break

    my $html = <<END_TITLE_HTML;
<div id="titleBar">
    <img id="oaiIcon" src="/images/OA100.gif" height="70" width="100" alt="OAI Icon" />
    <div id="oaiTitle">$title</div>
<div id="menu">

<dl id="firstMenu">
<dt onmouseover="javascript:dropDown();"><a href="/organization/">About OAI</a></dt>
</dl>

<dl>
<dt onmouseover="javascript:dropDown('smenu3');">Community</dt>
<dd id="smenu3">
<ul>
    <li><a href="https://groups.google.com/d/forum/resourcesync">ResourceSync group</a></li>
    <li><a href="https://groups.google.com/d/forum/oai-announce">OAI-announce</a></li>
    <li><a href="https://groups.google.com/d/forum/oai-pmh">OAI-PMH group</a></li>
    <li><a href="https://groups.google.com/d/forum/oai-ore">OAI-ORE group</a></li>
    <li><a href="http://www.openarchives.org/pipermail/oai-general/">OAI-general archives</a></li>
    <li><a href="http://www.openarchives.org/pipermail/oai-implementers/">OAI-PMH implementers archives</a></li>
    <li><a href="http://www.openarchives.org/Register/BrowseSites">OAI-PMH Data providers</a></li>
    <li><a href="http://www.openarchives.org/service/listproviders.html">OAI-PMH Service providers</a></li>
    <li><a href="/ore/community/">OAI-ORE Community</a></li>
</ul>
</dd>
</dl>

<dl>
<dt onmouseover="javascript:dropDown('smenu2');">Specifications</dt>
<dd id="smenu2">
<ul>
<li><a href="/OAI/openarchivesprotocol.html">OAI-PMH Version 2</a></li>
<li><a href="/OAI/2.0/guidelines.htm">OAI-PMH Guidelines</a></li>
<li><a href="/ore/toc">OAI-ORE</a></li>
<li><a href="/rs/toc">ResourceSync</a></li>
<li><a href="/documents/FAQ.html">FAQ</a></li>
<li><a href="/documents/">More Documents</a></li>
</ul>
</dd>
</dl>

<dl>
<dt onmouseover="javascript:dropDown('smenu1');">Projects</dt>
<dd id="smenu1">
<ul>
<li><a href="/rs">ResourceSync</a></li>
<li><a href="/ore">OAI-ORE</a></li>
<li><a href="/pmh/">OAI-PMH</a></li>
</ul>
</dd>
</dl>
 
<dl>
<dt onmouseover="javascript:dropDown();"><a href="/">Home</a></dt>
</dl>

</div> <!--menu-->
</div> <!--titleBar-->
END_TITLE_HTML
    return($html);
}
