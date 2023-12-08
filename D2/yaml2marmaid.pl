#! /usr/bin/env perl

use strict;
use warnings;
use YAML::XS qw(LoadFile);
use Data::Dumper;

my $file = shift;
my $yaml = LoadFile($file);

my $mermaid = "classDiagram\n\n";
foreach my $class (keys %{$yaml->{'classes'}}) {
    my $attrs = $yaml->{'classes'}->{$class}->{'attributes'};
    my $methods = $yaml->{'classes'}->{$class}->{'methods'};
    my $isa = $yaml->{'classes'}->{$class}->{'isa'};

    #print Dumper($isa);exit;

    $mermaid .= "class $class";
    if ($isa) {
        $mermaid .= " extends ".$isa->[0];
    }
    $mermaid .= " {\n";
    foreach my $attr (@$attrs) {
        my $attr_type = $attr->{type};
        my $attr_name = $attr->{name};
        $mermaid .= "    $attr_name: $attr_type\n";
    }
    $mermaid .= "\n";
    #foreach my $method (keys %$methods) {
    #    my $method_args = $methods->{$method};
    #    my $args_string = join(', ', @$method_args);
    #    $mermaid .= "    $method($args_string)\n";
    #}
    $mermaid .= "}\n\n";
}

print $mermaid;
