<?xml version="1.0" encoding="utf-8"?>
<iso:schema xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2" schemaVersion="ISO19757-3" xmlns:xs="http://www.w3.org/2001/XMLSchema" xml:lang="en-US">
  <!--  Digital Library Research & Prototyping
        Los Alamos National Laboratory, Research Library,
        Prototyping Team,
        author: Stephan Drescher, email: stephand@lanl.gov 
        version: alpha 0.1 
        created: 10/11/2007
        licence: http://creativecommons.org/licenses/by-nc-sa/2.5/
    -->
  <iso:p>This is a prototype schema for the 
  <emph>Object Reuse and Exchange</emph>language.</iso:p>
  <!-- Namespaces declaration -->
  <!-- Atom vocabulary terms-->
  <iso:ns uri="http://www.w3.org/2005/Atom" prefix="atom" />
  <!-- ORE vocabulary terms (not implemented we are still fully atom complient ) -->
  <iso:ns uri="http://www.openarchives.org/ore/terms/" prefix="ore" />
  <!-- Dublin Core elements  (not implemented) -->
  <iso:ns uri="http://purl.org/dc/elements/1.1/" prefix="dc" />
  <!-- Dublin Core terms (not implemented) -->
  <iso:ns uri="http://purl.org/dc/terms/" prefix="dcterms" />
  <!-- OWL vocabulary terms (not implemented) -->
  <iso:ns uri="http://www.w3.org/2002/07/owl#" prefix="owl" />
  <!-- RDF vocabulary terms (not implemented) -->
  <iso:ns uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#" prefix="rdf" />
  <iso:title>Atom and Atom Publishing Protocol schematron validator</iso:title>
  <!--
        FEED - Child elements of atom:feed that are in the Atom namespace pertain to the Resource Map,                       
        i.e. Atom feed.                                                                     
    -->
  <iso:phase id="AtomFeed">
    <iso:active pattern="OREAtom" />
  </iso:phase>
  <!--
        ENTRY - Child elements of atom:entry that are in the Atom namespace pertain to the Atom entry only;                   
        they have no correspondence in the ORE Model.              
    -->
  <iso:phase id="AtomEntry">
    <iso:active pattern="OREAtom" />
  </iso:phase>
  <!-- Atom format rules -->
  <!-- Start ORE Atom serialization validation based on Atom's RFC 4287 and ORE's Specification - Resource Map Profile of Atom from 10102007 -->
  <iso:pattern id="OREAtom">
    <!-- FEED -->
    <iso:rule context="atom:feed">
      <!--The atom:id child element of atom:feed pertains to the Atom feed only and has no correspondence in the        
                ORE Model;  
                atomId - MUST contain exactly one atom:id element. The atom:id element has no ORE-specific semantics.  -->
      <iso:assert test="count(atom:id) = 1">An atom feed must contain one and only one atom:id element. [RFC 4287, sec.4.1.1]</iso:assert>
      <!-- atomTitle - MUST contain exactly one atom:title element. -->
      <iso:assert test="count(atom:title) = 1">An atom feed must contain one and only one atom:title element. [RFC 4287, sec.4.1.1]</iso:assert>
      <!-- atomUpdated - MUST contain exactly one atom:updated element. -->
      <iso:assert test="count(atom:updated) = 1">An atom feed must contain one and only one atom:updated element. [RFC 4287, sec.4.1.1]</iso:assert>
      <iso:report test="not(string(atom:updated))">You must provide a date value for the modification date as an atom:updated value (
      <iso:value-of select="string(atom:updated)" />). [RFC 4287, sec.4.1.1]</iso:report>
      <iso:report test="not(string(atom:updated) castable as xs:dateTime)">Not a date format value used</iso:report>
      <!-- atomAuthor - MUST contain one or more author The atom:author element conveys the authoring authority          
                of the Resource Map.-->
      <iso:assert test="atom:author">An atom:feed must have an atom:author. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:assert>
      <!-- atomContributor - MAY contain any number of atom:contributor elements. -->
      <iso:assert test="atom:contributor or not(atom:contributor)">An atom:feed can have any number of atom:contributor. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:assert>
      <!-- atomGenerator - MUST NOT contain more than one atom:generator element. -->
      <iso:assert test="count(atom:generator) &lt;= 1">An atom feed cannot contain more than more than one atom:generator element. [RFC 4287, sec.4.1.1]</iso:assert>
      <!--atomIcon - MUST NOT contain more than one atom:icon element. 
                Use of an atom:icon element with content of "http://www.openarchives.org/ore/logos/ore_icon.png"   
                is RECOMMENDED to allow recognizing the Atom Feed Document as a Resource Map Document. -->
      <iso:assert test="count(atom:icon) &lt;= 1">An atom feed cannot contain more than one atom:icon element. [RFC 4287, sec.4.1.1]</iso:assert>
      <!-- atomLogo - MUST NOT contain more than one atom:logo element.                                                  
                Use of an atom:logo element with content of "http://www.openarchives.org/ore/logos/ore_logo.png"   
                is RECOMMENDED to allow recognizing the Atom Feed Document as a Resource Map Document. -->
      <iso:assert test="count(atom:logo) &lt;= 1">An atom feed cannot contain more than one atom:logo element. [RFC 4287, sec.4.1.1]</iso:assert>
      <!-- atomRights - MUST NOT contain more than one atom:rights element.                                              
                It is RECOMMENDED to express the rights pertaining to the Resource Map by setting the content of 
                the atom:rights element to the URI of a rights license.  -->
      <iso:assert test="count(atom:rights) &lt;= 1">An atom feed cannot contain more than one atom:rights element. [RFC 4287, sec.4.1.1]</iso:assert>
      <!--  atomSubtitle - MUST NOT contain more than one atom:subtitle element.  -->
      <iso:assert test="count(atom:subtitle) &lt;= 1">An atom feed cannot contain more than one atom:subtitle element. [RFC 4287, sec.4.1.1]</iso:assert>
      <iso:assert test="not(atom:published)">An atom feed cannot have an atom:published element. [RFC 4287, sec.4.1.1]</iso:assert>
      <!-- feed:link -->
      <!--atom:link element for the feed section -->
      <iso:extends rule="feedLinks" />
      <!-- atomCategory - MUST contain exactly one atom:category element identifying the Atom Feed Document              
                as a Resource Map Document.                                                                    
                This element has a scheme attribute value of "http://openarchives.org/ore/terms",              
                a term attribute value of "http://openarchives.org/ore/terms/ResourceMap", and a label         
                attribute value of "Resource Map".                                                             
                atomCategory - MAY contain any number of atom:category elements in addition to the aforementioned one. 
            -->
      <iso:assert test="count(atom:category[@term='http://openarchives.org/ore/terms/ResourceMap']) &lt;= 1">An atom feed must have exactly one atom:category 'ResourceMap' element. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:assert>
      <iso:report test="not(string(atom:category[@term='http://www.openarchives.org/ore/terms/ResourceMap']/@scheme) eq 'http://www.openarchives.org/ore/terms/')">This Resource Map requires a schema attribute of ' 
      <iso:value-of select="atom:category[@term='http://www.openarchives.org/ore/terms/ResourceMap']/@scheme" />'</iso:report>
      <!-- ORE does not include the atom:content element into its profile -->
      <iso:report test="atom:content">An atom feed cannot have an atom:content element. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:report>
      <!-- An atom feed MUST NOT have a source element following the Atom spec -->
      <iso:report test="atom:source">An atom feed cannot have an atom:source element. [RFC 4287, sec.4.1.1]</iso:report>
      <!--                                            
                extensibleElement - MAY contain any number of child elements from namespaces other than the Atom namespace.   
                These elements convey Types and Relationships pertaining to                               
                the Aggregation (URI-A = URI-R#aggregation) described by the Resource Map. 
            -->
    </iso:rule>
    <!--ENTRY -->
    <iso:rule context="atom:entry">
      <!-- atomId - MUST contain exactly one atom:id element. The atom:id element has no ORE specific semantics. 
                The content of this atom:id element MUST NOT be the URI of the Aggregated Resource (URI-AR).    
            -->
      <iso:assert test="count(atom:id) = 1">An atom entry must have one and only one atom:id element. [RFC 4287, sec.4.1.2]</iso:assert>
      <iso:assert test="atom:id">You must provide an Id value for the atom:id element.</iso:assert>
      <!-- atomTitle - MUST contain exactly one atom:title element. -->
      <iso:assert test="count(atom:title) = 1">An atom entry must have one and only one atom:title element. (RFC 4287, sec.4.1.2)</iso:assert>
      <iso:assert test="string(atom:title)">You must provide a title for the atom:title element value. [RFC 4287, sec.4.1.2]</iso:assert>
      <!-- atomUpdated - MUST contain exactly one atom:updated element. -->
      <iso:assert test="count(atom:updated) = 1">An atom entry must contain one and only one atom:updated element. [RFC 4287, sec.4.1.2]</iso:assert>
      <iso:report test="not(string(atom:updated))">You must provide a date value for the modification date as an atom:updated value (
      <iso:value-of select="string(atom:updated)" />). [RFC 4287, sec.4.1.1]</iso:report>
      <iso:report test="not(string(atom:updated) castable as xs:dateTime)">Not a date Format</iso:report>
      <iso:let name="FEEDMODIFIED" value="/atom:feed/atom:updated" />
      <iso:let name="ENTRYMODIFIED" value="atom:updated" />
      <iso:report test="((if(string($FEEDMODIFIED) != '') then string($FEEDMODIFIED) cast as xs:dateTime else return) &lt; (if(string($ENTRYMODIFIED) != '') then string($ENTRYMODIFIED) cast as xs:dateTime else return))">The date entrty 
      <iso:value-of select="year-from-dateTime($ENTRYMODIFIED)" />:
      <iso:value-of select="month-from-dateTime($ENTRYMODIFIED)" />:
      <iso:value-of select="day-from-dateTime($ENTRYMODIFIED)" />:
      <iso:value-of select="hours-from-dateTime($ENTRYMODIFIED)" />:
      <iso:value-of select="minutes-from-dateTime($ENTRYMODIFIED)" />:
      <iso:value-of select="seconds-from-dateTime($ENTRYMODIFIED)" />is later then feed date 
      <iso:value-of select="year-from-dateTime($FEEDMODIFIED)" />:
      <iso:value-of select="month-from-dateTime($FEEDMODIFIED)" />:
      <iso:value-of select="day-from-dateTime($FEEDMODIFIED)" />:
      <iso:value-of select="hours-from-dateTime($FEEDMODIFIED)" />:
      <iso:value-of select="minutes-from-dateTime($FEEDMODIFIED)" />:
      <iso:value-of select="seconds-from-dateTime($FEEDMODIFIED)" /></iso:report>
      <!-- atomPublished - MUST NOT contain more than one atom:published element. -->
      <iso:assert test="count(atom:published) &lt;= 1">An ore-atom entry cannot have more than one atom:published element. [RFC 4287, sec.4.1.2]</iso:assert>
      <!-- atomSource - MUST NOT contain more than one atom:source element. -->
      <iso:assert test="count(atom:source) &lt;= 1">An ore-atom entry cannot have more than one atom:source element. [RFC 4287, sec.4.1.2]</iso:assert>
      <!-- atomSummary - MUST NOT contain more than one atom:summary element. -->
      <iso:assert test="count(atom:summary) &lt;= 1">An ore-atom entry cannot have more than one atom:summary element.</iso:assert>
      <!-- atomSubtitle - MUST not contain an atom:subtitle element. -->
      <iso:report test="atom:subtitle">An ore-atom entry cannot have an atom:subtitle element. [RFC 4287, sec.4.1.2]</iso:report>
      <!-- atomRights - MUST NOT contain any atom:rights elements. Rights information is inherited 
                in the following order:                                                                         
                from the atom:rights element contained in an atom:source child element                          
                of the atom:entry if such atom:source element exists;                                           
                from the atom:rights elements of the atom:feed element if no such atom:source element exists.
            -->
      <iso:report test="atom:rights">An ore-atom entry must not have any rights element</iso:report>
      <iso:report test="not(atom:source/atom:rights or /atom:feed/atom:rights)">Error, You still need to provide a copyrights value for this ore-atom object</iso:report>
      <!--atom:link element for the entry section -->
      <iso:extends rule="entryLinks" />
      <!-- 
                atomEntry MUST NOT contain any atom:author elements. Authorship information is inherited                      
                in the following order:                                                                                
                from the atom:author element contained in an atom:source child element                                 
                of the atom:entry if such atom:source element exists;                                                  
                from the atom:author elements of the atom:feed element if no such atom:source element exists.
            -->
      <iso:report test="atom:author">An ore-atom entry element must not have an atom:author element. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.2.1]</iso:report>
      <iso:report test="not(atom:source/atom:author or /atom:feed/atom:author)">Error, You still need to provide a author value for this ore-atom object</iso:report>
      <!-- atomContributor - MAY contain any number of atom:contributor elements.-->
      <iso:assert test="atom:contributor or not(atom:contributor)">An ore-atom entry element may have an atom:contributor element. (ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1)</iso:assert>
      <!-- 
                atomCategory MAY contain any number of atom:category elements.                                                
                The atom:category element to express that the atom:entry conveys an Aggregated Resource                
                is implicit and can be derived from the fact that the atom:feed of                                     
                which the atom:entry is a child element has an atom:category that types it as a Resource Map. 
            -->
      <iso:assert test="atom:category[@term='http://openarchives.org/ore/terms/AggregatedResource'] or not(atom:category)">An ore-atom entry may have atom:category 'AggregatedResource' elements. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.2]</iso:assert>
      <!--
                extensibleElement - MAY contain any number of child elements from namespaces other than the Atom namespace.   
                These elements convey Types and Relationships pertaining to                              
                the Aggregated Resource (URI-AR) conveyed by the Atom entry. 
            -->
      <iso:assert test="atom:extensibleElement or not(atom:extensibleElement)">An ore-atom entry may have an atom:extensibleElement element. (ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.2)</iso:assert>
      <!-- atomContent - MUST NOT contain any atom:content elements. -->
      <iso:report test="atom:content">An ore-atom entry cannot have an atom:content element. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.3]</iso:report>
    </iso:rule>
    <iso:rule context="atom:author">
      <iso:assert test="count(/atom:feed/atom:author/atom:name) = 1">An ore-atom author element must have one and only one atom:name element. (RFC 4287, sec.3.2)</iso:assert>
      <iso:assert test="string(/atom:feed/atom:author/atom:name)">You must provide a ore-atom name for the atom:author element value. (RFC 4287, sec.3.2)</iso:assert>
      <iso:assert test="count(/atom:feed/atom:author/atom:uri) &lt;= 1">An ore-atom author element cannot have more than one atom:uri element. [RFC 4287, sec.3.2]</iso:assert>
      <!-- Datatype check for the authors URI -->
      <iso:report test="not(string(/atom:feed/atom:author/atom:uri) castable as xs:anyURI)">Not a valid URI format value used</iso:report>
      <iso:assert test="count(/atom:feed/atom:author/atom:email) &lt;= 1">An  ore-atom author element cannot have more than one atom:email element. [RFC 4287, sec.3.2]</iso:assert>
    </iso:rule>
    <iso:rule context="atom:category">
      <iso:assert test="@term">An atom:category element must have a term attribute. [RFC 4287, sec.4.2.2]</iso:assert>
    </iso:rule>
    <iso:rule context="atom:contributor">
      <iso:assert test="count(atom:name) = 1">An atom:contributor element must have one and only one atom:name element. [RFC 4287, sec.3.2]</iso:assert>
      <iso:assert test="count(atom:uri) &lt;= 1">An atom:contributor element cannot have more than one atom:uri element. [RFC 4287, sec.3.2]</iso:assert>
      <iso:assert test="count(atom:email) &lt;= 1">An atom:contributor element cannot have more than one atom:email element. [RFC 4287, sec.3.2]</iso:assert>
    </iso:rule>
    <iso:rule context="atom:link">
      <iso:assert test="@href">An atom:link must have one and only one href attribute. [RFC 4287, sec.4.2.7]</iso:assert>
    </iso:rule>
    <!-- details about links for Feed and Entry-->
    <iso:rule abstract="true" id="feedLinks">
      <!-- feed links -->
      <!-- 
                atomLink - MUST contain one atom:link element with a rel attribute value of "self".                           
                This conveys the preferred URI for retrieving Atom Feed Documents representing this Atom feed.     
                The href attribute value of this atom:link element MUST be the URI of the Resource Map (URI-R).
                
                atomLink - MAY contain any number of atom:link elements with a rel attribute value of "related".              
                Such an atom:link element is used to convey URIs other than URI-A (= URI-R#aggregation)            
                by which the Aggregation described by the Resource Map is known.                                   
                
                The href attribute value of this atom:link element must be a URI other than URI-A by which the     
                Aggregation described by the Resource Map is known. 
                
                atomLink - MUST NOT contain more than one atom:link element with a rel attribute value of "alternate"         
                that has the same combination of type and hreflang attribute values.                               
                atomLink - MAY contain additional atom:link elements beyond those described above.
            -->
      <iso:let name="URIR" value="string(atom:link[@rel='self']/@href)" />
      <!-- Datatype check for the authors URIR -->
      <iso:report test="not(string(atom:link[@rel='self']/@href) castable as xs:anyURI)">Not a valid URIR format value used</iso:report>
      <iso:let name="URIA" value="string(concat($URIR,'#aggregation'))" />
      <!-- Datatype check for the authors URIA -->
      <iso:report test="not($URIA castable as xs:anyURI)">Not a valid URIA format value used</iso:report>
      <iso:assert test="count(atom:link[@rel='self']) &lt;= 1">An atom feed cannot contain more than one atom:link 'self' element. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:assert>
      <iso:assert test="atom:link[@type='application/atom+xml']">An atom atom:link 'self' element needs to match 'application/atom+xml'. [RFC 4287, sec.4.1.1]</iso:assert>
      <iso:assert test="count(atom:link[@rel='alternate']) &lt;= 1">An atom feed cannot have more than one atom:link 'alternate' element. [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:assert>
      <iso:report test="string($URIA) = atom:link[@rel='related']/@href">Invalid usage of the Aggregation link, it must be other than 
      <iso:value-of select="$URIA"/>(
      <iso:value-of select="atom:link[@rel='related']/@href" />) [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:report>
    </iso:rule>
    <iso:rule abstract="true" id="entryLinks">
      <iso:assert test="atom:link" />
      <!-- entry links -->
      <!--
                The atom:link child element of atom:entry that expresses a relationship                                       
                with a value of "alternate" is used to convey an Aggregated Resource of the ORE Model                  
                (see also below);                                                                                      
                The atom:link child element of atom:entry that expresses a relationship                                       
                with a value of "via" is used to convey the Lineage of an Aggregated Resource,                         
                as defined in the the ORE Model (see also below).                                                      
                Child elements of atom:entry that are not not in the Atom namespace, i.e. extension child                     
                elements of atom:entry, pertain to the Aggregated Resource that is conveyed using                      
                the atom:entry. They correspond to Types and Relationships pertaining to                               
                the Aggregated Rersource, as defined in the the ORE Model.
                
                atomLink - MUST contain one atom:link element with a rel attribute value of "alternate".                      
                This link conveys the Aggregated Resource. The href attribute value of this atom:link             
                element MUST be the URI of the Aggregated Resource (URI-AR).                                      
            -->
      <iso:assert test="count(atom:link[@rel='alternate']) = 1">An entry must have one and only one link element with a rel attribute of 'alternate'</iso:assert>
      <iso:report test="string(atom:link[@rel='alternate'])">You must provide an alternate link value for the atom:link element entry value.[ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:report>
      <iso:let name="URIAR" value="string(atom:link[@rel='alternate']/@href)" />
      <!-- Datatype check for the authors URIAR -->
      <iso:report test="not(string(atom:link[@rel='alternate']/@href) castable as xs:anyURI)">Not a valid URIAR format value used</iso:report>
      <!-- 
                atomLink - MUST NOT contain more than one atom:link element with a rel attribute value of "via".              
                This link conveys the Lineage of the Aggregated Resource. The href attribute value of this        
                atom:link element MUST be the URI of a Resource Map with which the Aggregated Resource            
                has a Lineage relationship. 
            -->
      <iso:assert test="count(atom:link[@rel='via']) &lt;= 1">An entry cannot have more than one link element with a rel attribute of 'via'</iso:assert>
      <!-- Don not allow to create a lineage with its self-->
      <iso:let name="URIR" value="string(/atom:feed/atom:link[@rel='self']/@href)" />
      <iso:report test="(string(atom:link[@rel='via']/@href) = $URIR)">MUST not be the URI of this Resource Map 
      <iso:value-of select="$URIR" />with which the Aggregated Resource tries to create a Lineage relationship [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:report>
      <!-- 
                atomLink - MUST NOT contain more than one atom:link element with a rel attribute value of "self".             
                This is the preferred URI for retrieving Atom Entry Documents representing this Atom entry.       
                The href attribute value of this atom:link element MUST NOT be the URI of                         
                the aggregated resource (URI-AR).                                                                 
                atomLink - MUST NOT contain any atom:link elements other than the aformentioned ones.    
            -->
      <iso:assert test="count(atom:link[@rel='self']) &lt;= 1">An entry cannot have more than one link element with a rel attribute of 'self' [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:assert>
      <iso:assert test="if (count(atom:link[@rel='self']) &gt;= 1) then ((substring($URIAR,1) = atom:link[@rel='self']/@href)) else not(atom:link[@rel='self'])">Invalid usage of the Aggrigation Resource link, it must be other than 
      <iso:value-of select="$URIAR" />(
      <iso:value-of select="atom:link[@rel='self']/@href" />) [ORE Specification - Resource Map Profile of Atom from 10102007, sec. 4.1.1]</iso:assert>
      <!-- end entry links -->
    </iso:rule>
  </iso:pattern>
  <!-- end OREAtom -->
</iso:schema>
