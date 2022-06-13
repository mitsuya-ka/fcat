<#
.SYNOPSIS
 Gets the content of the item at the specified location w/ file name.
.DESCRIPTION
 The `fcat.ps1` script gets the content of the item at the location specified by the path with file name,
 such as the text in a file or the content of a function.
 For files, the content is read one line at a time and returns a collection of objects,
 each of which represents a line of content.
.NOTES
 This script move from module(function Get-Context-FileName).
 By setting Pattern param, it can be displayed from the position where the param appears.
.PARAMETER Path
 Path
.PARAMETER LiteralPath
 LiteralPath
.PARAMETER ReadCount
 ReadCount
.PARAMETER TotalCount
 TotalCount
.PARAMETER Tail
 Tail
.PARAMETER Filter
 Filter
.PARAMETER Include
 Include
.PARAMETER Exclude
 Exclude
.PARAMETER Force
 Force
.PARAMETER Credential
 Credential
.PARAMETER Delimiter
 Wait
.PARAMETER Wait
 Wait
.PARAMETER Raw
 Raw
.PARAMETER Encoding
 Encoding
.PARAMETER AsByteStream
 Stream
.PARAMETER Stream
 Stream
.PARAMETER Pattern
 Pattern
.EXAMPLE
 PS >fcat.ps1 -Path a.txt
.EXAMPLE
 PS >Get-ChildItem *.txt | fcat.ps1
#>
[CmdletBinding(DefaultParameterSetName = "Path")]
param (
	[Parameter(Mandatory = $true, ValueFromPipeLineByPropertyName = $true, Position = 0, ParameterSetName = "Path")]
	[String[]] $Path,
	[Parameter(Mandatory = $true, ValueFromPipeLineByPropertyName = $true, ParameterSetName = "LiteralPath")]
	[Alias("PSPath", "LP")]
	[String[]] $LiteralPath,
	[Parameter(ValueFromPipeLineByPropertyName = $true)]
	[Int64] $ReadCount,
	[Parameter(ValueFromPipeLineByPropertyName = $true)]
	[Alias("First", "Head")]
	[Int64] $TotalCount,
	[Parameter(ValueFromPipeLineByPropertyName = $true)]
	[Alias("Last")]
	[Int32] $Tail,
	[String] $Filter,
	[String[]] $Include,
	[String[]] $Exclude,
	[Switch] $Force,
	[Parameter(ValueFromPipeLineByPropertyName = $true)]
	[pscredential] $Credential,
	[String] $Delimiter,
	[Switch] $Wait,
	[Switch] $Raw,
	[ValidateSet("ascii", "bigendianunicode", "bigendianutf32", "oem", "unicode", "utf7", "utf8", "utf8BOM", "utf8NoBOM", "utf32")]
	[String] $Encoding = "oem",
	[Switch] $AsByteStream,
	[String] $Stream,
	[String] $Pattern
)
Begin {
	[Void] $PSBoundParameters.Remove('Pattern')
	$PSBoundParameters['Encoding'] = $Encoding
}
process {
	$p = @(Get-Content @PSBoundParameters)
	if ( $Pattern ) {
		switch ( $p ) {
			default {
				if ( $_.ReadCount -eq $p[0].ReadCount ) {
					Write-Host $_.PSChildName -ForegroundColor Cyan
					$s = $null
				}
				if ( $_ -match $Pattern ) { $s = $true }
				if ( $s ) {
					$_
				}
			}
		}
	}
	else {
		switch ( $p ) {
			default {
				if ( $_.ReadCount -eq $p[0].ReadCount ) {
					Write-Host $_.PSChildName -ForegroundColor Cyan
				}
				$_
			}
		}
	}
}
