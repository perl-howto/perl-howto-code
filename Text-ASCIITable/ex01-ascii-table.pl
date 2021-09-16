#!/usr/bin/env perl 
use strict;
use warnings;

use Text::ASCIITable;

my $table = Text::ASCIITable->new( { headingText => 'Sales per Year' } );

$table->setCols( 'Year', 'Sales' );

$table->alignCol( 'Year' => 'left', 'Sales' => 'right' );

$table->addRow( 2005, "3000.00" );
$table->addRow( 2006, "4000.00" );
$table->addRow( 2007, "3500.00" );
$table->addRow( 2008, "5800.00" );

$table->addRowLine;
$table->addRow( 'Average', "4075.00" );

print $table;
