<?xml version="1.0" encoding="UTF-8" ?>
<iso:schema xmlns:iso="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    schemaVersion="ISO19757-3" xmlns:sch="http://www.ascc.net/xml/schematron">
    <iso:ns prefix="iso" uri="http://purl.oclc.org/dsdl/schematron"/>
    <iso:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
    <iso:ns prefix="atom" uri="http://www.w3.org/2005/Atom"/>
    <iso:ns prefix="ore" uri="http://www.openarchives.org/ore/terms/"/>
    <iso:ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <iso:ns prefix="dcterms" uri="http://purl.org/dc/terms/"/>
    <iso:ns prefix="owl" uri="http://www.w3.org/2002/07/owl#"/>
    <iso:ns prefix="rdf" uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <iso:p>This is a prototype schema for the Object Reuse and Exchange (ORE) Atom-based
        serialization.</iso:p>
    <iso:p>Digital Library Research + Prototyping Los Alamos National Laboratory, Research Library,
        Prototyping Team, author: Stephan Drescher, email: stephand@lanl.gov version: 0.9 beta
        created: 05-27-2008 licence: http://creativecommons.org/licenses/by-nc-sa/2.5/ </iso:p>
    <iso:title>Atom and Atom Publishing Protocol schematron validator</iso:title>
    <iso:phase id="AtomFeed">
        <iso:active pattern="NS"/>
        <iso:active pattern="Feed"/>
        <iso:active pattern="FeedId"/>
        <iso:active pattern="FeedTitle"/>
        <iso:active pattern="FeedEntry"/>
        <iso:active pattern="FeedAuthor"/>
        <iso:active pattern="FeedUpdated"/>
        <iso:active pattern="FeedTitle"/>
        <iso:active pattern="FeedSubtitle"/>
        <iso:active pattern="FeedGenerator"/>
        <iso:active pattern="FeedIcon"/>
        <iso:active pattern="FeedLogo"/>
        <iso:active pattern="FeedPublished"/>
        <iso:active pattern="FeedCategory"/>
        <iso:active pattern="FeedContent"/>
        <iso:active pattern="FeedLink"/>
        <iso:active pattern="FeedContributor"/>
        <iso:active pattern="FeedRdfExtension"/>
    </iso:phase>
    <iso:phase id="AtomEntry">
        <iso:active pattern="EntryId"/>
        <iso:active pattern="EntryTitle"/>
        <iso:active pattern="EntryAuthor"/>
        <iso:active pattern="EntryUpdated"/>
        <iso:active pattern="EntryTitle"/>
        <iso:active pattern="EntrySubtitle"/>
        <iso:active pattern="EntryGenerator"/>
        <iso:active pattern="EntryIcon"/>
        <iso:active pattern="EntryLogo"/>
        <iso:active pattern="EntryPublished"/>
        <iso:active pattern="EntryCategory"/>
        <iso:active pattern="EntrySource"/>
        <iso:active pattern="EntryContent"/>
        <iso:active pattern="EntryLink"/>
        <iso:active pattern="EntryContributor"/>
        <iso:active pattern="EntrySummary"/>
        <iso:active pattern="EntryRdfExtension"/>
    </iso:phase>
    <iso:phase id="Other">
        <iso:active pattern="Untested"/>
    </iso:phase>
    <iso:pattern id="NS">
        <iso:rule context="atom:*">
            <iso:assert diagnostics="NamespaceError_001" see="Model Requirements #1"
                test="namespace-uri()='http://www.w3.org/2005/Atom'">An ORE-Atom 'atom:feed' MUST
                have exactly one 'http://www.w3.org/2005/Atom' namespace attribute value.
            </iso:assert>
        </iso:rule>

        <iso:rule context="/feed">
            <iso:assert diagnostics="NamespaceError_001" see="Model Requirements #1"
                test="string-length(namespace-uri(.)) &lt; 1">Empty Namespace, an ORE-Atom
                'atom:feed' MUST have exactly one 'http://www.w3.org/2005/Atom' namespace attribute
                value. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="Feed">
        <iso:rule context="xml">
            <iso:assert test="*">Document does not contain any child element</iso:assert>
        </iso:rule>
        <iso:rule context="/*">
            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="/atom:feed"
                >Root element MUST be a 'atom:feed' element, Please provide a single 'atom:feed'
                element, child elements and its values! </iso:assert>
            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="namespace-uri()='http://www.w3.org/2005/Atom'">An ORE-Atom 'atom:feed' MUST
                have exactly one 'http://www.w3.org/2005/Atom' namespace attribute value. </iso:assert>

            <iso:assert test="*">Document does not contain any child element</iso:assert>
        </iso:rule>
        <iso:rule context="/atom:feed">
            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="*">Empty
                'atom:feed' - it does not contain any child element</iso:assert>
        </iso:rule>

    </iso:pattern>
    <iso:pattern id="FeedId">
        <iso:p>All basic atom feed ID checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="atom:id"
                >Missing ORE-Atom 'atom:feed' 'atom:id' element. Please provide a single 'atom:id'
                element and its value! </iso:assert>
            <iso:report test="not(atom:id)">Missing ORE-Atom 'atom:feed' 'atom:id'
            element.</iso:report>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:id">

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="normalize-space(.)">Empty value, 'atom:feed' has an 'atom:id' element null
                value. </iso:assert>
            <iso:report test="not(normalize-space(.))">ORE-Atom 'atom:feed' 'atom:id' element
                without value.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(../atom:id) = 1">An ORE-Atom 'atom:feed' MUST contain one and only one
                'atom:id' element. </iso:assert>
            <iso:report test="not(count(../atom:id) = 1)">Incorrect amount of ORE-Atom atom:id
                references: <iso:value-of select="count(../atom:id)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedTitle">
        <iso:p>All basic atom feed title checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="atom:title"
                >Missing ORE-Atom 'atom:feed' 'atom:title' element. Please provide a single
                'atom:title' element and its value. </iso:assert>
            <iso:report test="not(atom:title)">Missing ORE-Atom 'atom:feed' 'atom:title'
            element.</iso:report>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:title">

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="normalize-space(.)">Empty 'atom:feed' 'atom:title' element </iso:assert>
            <iso:report test="not(normalize-space(.))">ORE-Atom 'atom:feed' 'atom:title' element
                without value.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(../atom:title) = 1">An ORE-Atom 'atom:feed' MUST contain one and only
                one 'atom:title' element. </iso:assert>
            <iso:report test="not(count(../atom:title) = 1)">Incorrect amount of ORE-Atom
                'atom:feed' 'atom:title' references: <iso:value-of select="count(../atom:title)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedEntry">
        <iso:p>Basic atom entry exists checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="atom:entry"
                >An ORE-Atom 'atom:feed' MUST have at least one atom:entry element. </iso:assert>
            <iso:report test="not(atom:entry)">Missing ORE-Atom 'atom:feed' 'atom:entry'
                    references:<iso:value-of select="count(atom:entry)"/>
            </iso:report>
        </iso:rule>
        <iso:p>Basic atom entry not NULL check.</iso:p>

        <iso:rule context="/atom:feed/atom:entry">
            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(child::*) > 0">If an ORE-Atom 'atom:feed' has an 'atom:entry' element,
                this MUST have at least one 'atom:id', 'atom:title' and 'atom:updated' child
                element. </iso:assert>
            <iso:report test="not(count(child::*) > 0)">An ORE-Atom 'atom:feed' has NO 'atom:entry'
                element, this MUST have at least one 'atom:id', 'atom:title' and 'atom:updated'
                child element.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedUpdated">
        <iso:p>All basic atom feed updated exists checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="atom:updated"> Missing ORE-Atom 'atom:feed' 'atom:updated' element. Please
                provide a single 'atom:update' element and its value. (Use ISO8601 date format -
                'yyyy-MM-ddTHH:mm:ssZ'). It MUST convey the date-time of most recent update of the
                Atom-based Resource Map. (same as dc:modified of ORE model) </iso:assert>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:updated">

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="normalize-space(.)"> Empty date value, for the modification date please
                provide an 'atom:updated' value. (Use ISO 8601 date format - 'yyyy-MM-ddTHH:mm:ssZ') </iso:assert>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(../atom:updated) = 1"> An ORE-Atom 'atom:feed' MUST contain one and only
                one 'atom:updated' element. </iso:assert>
            <iso:report test="not(count(../atom:updated) = 1)">Multiple ORE-Atom 'atom:feed'
                'atom:updated' references <iso:value-of select="count(../atom:update)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedAuthor">
        <iso:p>All basic atom feed author checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="atom:author">Missing ORE-Atom 'atom:feed' 'atom:author'. Please provide a
                single 'atom:author' element, child elements and values. This SHOULD convey
                meaningful authorship information for the Aggregation </iso:assert>
            <iso:report test="not(atom:author)">Missing ORE-Atom 'atom:feed' 'atom:author'
                references <iso:value-of select="count(../atom:author)"/>
            </iso:report>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:author">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="child::*"
                >Empty sub elements, 'atom:feed' 'atom:author' element. Please provide at least a
                'atom:name' child element </iso:assert>
            <iso:report test="not(count(child::*) > 0)">An ORE-Atom 'atom:feed' 'atom:author' has NO
                'atom:name' element, this MUST have one 'atom:name' and optional an 'atom:uri' and
                'atom:email' child element.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(atom:name) = 1">An ORE-Atom 'atom:feed' 'atom:author' element MUST have
                one and only one 'atom:name' element. </iso:assert>
            <iso:report test="not(count(atom:name) = 1)">Incorrect amount of ORE-Atom 'atom:feed'
                'atom:author' 'atom:name' references: <iso:value-of select="count(atom:name)"/>
            </iso:report>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="string(atom:name)">Empty value, in ORE-Atom 'atom:name'. Please provide a
                'atom:name' value for the 'atom:author' element. </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(atom:uri) &lt;= 1">An ORE-Atom 'atom:author' element MUST NOT have
                more than one 'atom:uri' element. </iso:assert>
            <iso:report test="count(atom:uri) > 1">Multiple ORE-Atom 'atom:feed' 'atom:author'
                'atom:uri' references <iso:value-of select="count(atom:uri)"/>
            </iso:report>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(atom:email) &lt;= 1">An ORE-Atom 'atom:author' element MUST NOT have
                more than one 'atom:email' element. </iso:assert>
            <iso:report test="count(atom:email) > 1">Multiple ORE-Atom 'atom:feed' 'atom:author'
                'atom:email' references <iso:value-of select="count(atom:email)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedContributor">
        <iso:p>All basic atom feed contributor checks.</iso:p>
        <iso:rule context="/atom:feed/atom:contributor">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="child::*"
                >Empty sub elements, 'atom:feed' 'atom:contributor' element. Please provide at least
                a 'atom:name' child element </iso:assert>
            <iso:report test="not(count(child::*) > 0)">An ORE-Atom 'atom:feed' 'atom:contributor'
                has NO 'atom:name' element, this MUST have one 'atom:name' and optional an
                'atom:uri' and 'atom:email' child element.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(atom:name) = 1">An ORE-Atom 'atom:feed' 'atom:author' element MUST have
                one and only one 'atom:name' element. </iso:assert>
            <iso:report test="not(count(atom:name) = 1)">Incorrect amount of ORE-Atom 'atom:feed'
                'atom:contributor' 'atom:name' references: <iso:value-of select="count(atom:name)"/>
            </iso:report>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="string(atom:name)">Empty value, in ORE-Atom 'atom:name'. Please provide a
                'atom:name' value for the 'atom:author' element. </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(atom:uri) &lt;= 1">An ORE-Atom 'atom:contributor' element MUST NOT
                have more than one 'atom:uri' element. </iso:assert>
            <iso:report test="count(atom:uri) > 1">Multiple ORE-Atom 'atom:feed' 'atom:contributor'
                'atom:uri' references <iso:value-of select="count(atom:uri)"/>
            </iso:report>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(atom:email) &lt;= 1">An ORE-Atom 'atom:contributor' element MUST NOT
                have more than one 'atom:email' element. </iso:assert>
            <iso:report test="count(atom:email) > 1">Multiple ORE-Atom 'atom:feed'
                'atom:contributor' 'atom:email' references <iso:value-of select="count(atom:email)"
                />
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedGenerator">
        <iso:p>All basic atom feed generator checks.</iso:p>

        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="atom:generator">Missing ORE-Atom 'atom:feed' 'atom:generator'. Please provide
                a single 'atom:generator' element and its value. An ORE-Atom atom:feed MUST have
                exactly one 'atom:generator' element. It MUST convey the author of the Atom based
                Resource Map; It corresponds with the dcterms:creator element introduced in the ORE
                Model as Metadata pertaining to a Resource Map. </iso:assert>
            <iso:report test="not(atom:generator)">Missing ORE-Atom 'atom:feed' 'atom:generator'
                references <iso:value-of select="count(../atom:generator)"/>
            </iso:report>
            <iso:report test="count(../atom:generator) > 1">Multiple ORE-Atom 'atom:feed'
                'atom:generator' references <iso:value-of select="count(../atom:generator)"/>
            </iso:report>
        </iso:rule>

        <iso:rule context="/atom:feed/atom:generator">

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="normalize-space(.)">Error! Empty value 'atom:generator' element. </iso:assert>
            <iso:report test="not(normalize-space(.))">ORE-Atom 'atom:feed' 'atom:generator' element
                without value.</iso:report>

            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1" test="@uri">The
                uri Attribute of this 'atom:generator' is REQUIRED and MUST convey a URI associated
                with the author of the ATOM-based Resource Map.</iso:assert>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="string-length(normalize-space(@uri)) > 1">Error! Empty value for
                'atom:generator' uri attribute. </iso:assert>
            <iso:report test="string-length(normalize-space(@uri)) &lt; 1">ORE-Atom 'atom:feed'
                'atom:generator' uri attribute without value.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedIcon">
        <iso:p>All basic atom feed icon checks.</iso:p>
        <iso:rule context="/atom:feed/atom:icon">

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="normalize-space(.)">Warning! Empty 'atom:icon' element </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:icon) &lt;= 1">An ORE-Atom 'atom:feed' MUST NOT contain more
                than one 'atom:icon' element. </iso:assert>
            <iso:report test="count(../atom:icon) > 1">Multiple ORE-Atom 'atom:feed' 'atom:icon'
                references <iso:value-of select="count(../atom:icon)"/>
            </iso:report>

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="../atom:icon = 'http://www.openarchives.org/ore/logos/ore_icon.png'">An ORE
                icon is available at "http://www.openarchives.org/ore/logos/ore_icon.png". (It is
                RECOMMENDED to allow recognition of the Atom Feed Document as a Resource Map
                Document.) </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedLogo">
        <iso:p>All basic atom feed logo checks.</iso:p>
        <iso:rule context="/atom:feed/atom:logo">

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="normalize-space(.)">Warning! Empty 'atom:logo' element </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:logo) &lt;= 1">An ORE-Atom 'atom:feed' MUST NOT contain more
                than one 'atom:logo' element. </iso:assert>
            <iso:report test="count(../atom:logo) > 1">Multiple ORE-Atom 'atom:feed' 'atom:logo'
                references <iso:value-of select="count(../atom:logo)"/>
            </iso:report>

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="../atom:logo = 'http://www.openarchives.org/ore/logos/ore_logo.png'">An ORE
                logo is available at "http://www.openarchives.org/ore/logos/ore_logo.png". (It is
                RECOMMENDED to allow recognition of the Atom Feed Document as a Resource Map
                Document) </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedRights">
        <iso:p>All basic atom feed rights checks.</iso:p>
        <iso:rule context="/atom:feed/atom:rights">

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="normalize-space(.)">Warning! Empty value 'atom:rights' element. (corresponds
                the dc:rights of ORE model) </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:rights) &lt;= 1">An ORE-Atom 'atom:feed' MUST NOT contain
                more than one 'atom:rights' element. </iso:assert>
            <iso:report test="count(../atom:rights) > 1">Multiple ORE-Atom 'atom:feed' 'atom:rights'
                references <iso:value-of select="count(../atom:rights)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedSubtitle">
        <iso:p>All basic atom feed subtitle checks.</iso:p>
        <iso:rule context="/atom:feed/atom:subtitle">

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:subtitle) &lt;= 1">An ORE-Atom 'atom:feed' MUST NOT contain
                more than one 'atom:subtitle' element. It SHOULD convey a meaningful subtitle for
                the Aggregation. </iso:assert>
            <iso:report test="count(../atom:subtitle) > 1">Multiple ORE-Atom 'atom:feed'
                'atom:subtitle' references <iso:value-of select="count(../atom:subtitle)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedPublished">
        <iso:p>All basic atom feed published checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:published)">An ORE-Atom 'atom:feed' MUST NOT have any
                'atom:published' element. </iso:assert>
            <iso:report test="atom:published">Error, 'atom:published' element in 'atom:feed'
            found.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedCategory">
        <iso:p>All basic atom feed category checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="atom:category">Missing 'atom:feed' 'atom:category' 'Aggregation' element.
                Please provide a single 'atom:category' element and its attribute value!
            </iso:assert>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:category">

            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="count(../atom:category[@term='http://www.openarchives.org/ore/terms/Aggregation']) = 1"
                >An ORE-Atom atom:feed MUST have exactly one 'atom:category' with attribute
                term='http://www.openarchives.org/ore/terms/Aggregation'. </iso:assert>

            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="count(../atom:category[@scheme='http://www.openarchives.org/ore/terms/']) >= 1"
                >An ORE-Atom atom:feed MUST at least one 'atom:category' with attribute
                scheme='http://www.openarchives.org/ore/terms/'. </iso:assert>

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #2"
                test="count(../atom:category[@label='Aggregation']) &lt;= 1">An ORE-Atom
                atom:feed MUST NOT contain more than one 'atom:category' with attribute
                label='Aggregation'. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedContent">
        <iso:p>All basic atom feed content checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:content)">An ORE-Atom 'atom:feed' MUST NOT have an 'atom:content'
                element. </iso:assert>
            <iso:report test="atom:content">Error, 'atom:content' element in 'atom:feed'
            found</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedSummary">
        <iso:p>All basic atom feed content checks.</iso:p>
        <iso:rule context="/atom:feed">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:summary)">An ORE-Atom 'atom:feed' MUST NOT have an 'atom:summary'
                element. </iso:assert>
            <iso:report test="atom:summary">Error, 'atom:summary' element in 'atom:feed'
            found.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedRdfExtension">
        <iso:p>All basic atom feed extension checks.</iso:p>
        <iso:rule context="/atom:feed/rdf:Description">
            <iso:let name="URIA" value="string(../atom:id)"/>
            <iso:let name="URIR" value="string(../atom:link[@rel='self']/@href)"/>

            <iso:assert diagnostics="ElementWarning_001" see="Model Requirements #1" test="child::*"
                >Warning! Empty container 'rdf:Description' element. </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../rdf:Description[@rdf:about='$URIA']) &lt;= 1">An ORE-Atom
                'atom:feed' MUST NOT contain more than one 'rdf:Description' element with as
                attribute value 'rdf:about' the URI-A of the Aggrigation. </iso:assert>
            <iso:report test="count(../rdf:Description[@rdf:about='$URIA']) > 1">Incorrect amount of
                RDF Aggregation references <iso:value-of
                    select="count(../rdf:Description[@rdf:about='$URIA'])"/>
            </iso:report>


            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../rdf:Description[@rdf:about='$URIR']) &lt;= 1">An ORE-Atom
                'atom:feed' MUST NOT contain more than one 'rdf:Description' element with as
                attribute value 'rdf:about' the URI-R of the Atom-based Resource Map. </iso:assert>
            <iso:report test="count(../rdf:Description[@rdf:about='$URIR']) > 1">Incorrect amount of
                RDF Resource Map references <iso:value-of
                    select="count(../rdf:Description[@rdf:about='$URIR'])"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FeedLink">

        <iso:p>All basic atom feed link checks.</iso:p>
        <iso:rule context="/atom:feed">
            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="atom:link[ @rel='self' ]">An ORE-Atom 'atom:feed' MUST contain one 'atom:link'
                element with a rel attribute value of "self". The href attribute value MUST be the
                URI of the Atom-based Resource Map(URI-R). This conveys the URI for retrieving Atom
                Feed Documents representing this Atom feed. </iso:assert>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:link">

            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="string(@href)">An ORE-Atom 'atom:link' element MUST contain one href
                attribute. </iso:assert>
            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="string(@rel)">An ORE-Atom 'atom:link' element MUST contain one rel attribute . </iso:assert>
            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:link[ @rel='license' ]) &lt;= 1">An ORE-Atom 'atom:feed'
                MUST NOT contain more than one 'atom:link' license element. The href atttribute
                value of this 'atom:link' element MUST be the URI of a rights expression pertaining
                to the Aggregation. The URI of a rights expression pertaining to the Aggregation
                (URI-A). It is RECOMMENDED that this rights expression is machine readable. </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:link[ @rel='self' ]) &lt;= 1">An ORE-Atom 'atom:feed' MUST
                NOT contain more than one 'atom:link' 'self' element. </iso:assert>
            <iso:report test="count(../atom:link[ @rel='self' ]) > 1">Incorrect amount of
                'atom:feed' 'atom:link' attribute 'rel=self' references <iso:value-of
                    select="count(../atom:link[@rel='self'])"/>
            </iso:report>

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="string(../atom:link[ @rel='self' ]/@type)='application/atom+xml'">An ORE-Atom
                'atom:link' 'self' element SHOULD contain attribute type 'application/atom+xml'. </iso:assert>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="string(../atom:link[ @rel='self' ]/@href)">An ORE-Atom 'atom:link' 'self'
                element MUST contain attribute href with the URI value of the Resource Map (URI-R). </iso:assert>

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="string(../atom:link[ @rel='self' ]/@type)">Empty value, An ORE-Atom
                'atom:link' 'self' element can e.g. contain the attribute type with the
                'application/atom+xml' value.</iso:assert>

            <iso:let name="URIA" value="../atom:id"/>
            <iso:let name="URIREL" value="../atom:link[ @rel='related' ]/@href"/>

            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="$URIA != $URIREL">Invalid usage of the Aggregation link, it must be another
                attribute href value than <iso:value-of select="$URIREL"/> by which the Aggregation
                described by the Resource Map (URI-A) <iso:value-of select="$URIA"/> is known. </iso:assert>

            <iso:let name="URIR" value="../atom:link[ @rel='self' ]/@href"/>

            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="$URIR != $URIREL">Invalid usage of the Aggregation link, it must be another
                attribute href value than <iso:value-of select="$URIREL"/> by which the Aggregation
                described by the Resource Map (URI-R) <iso:value-of select="$URIR"/> is known. </iso:assert>


            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="not(@rel='describes')">An ORE-Atom doesn't support the 'atom:link' element
                rel="describes" attribute. </iso:assert>

            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="not(@rel='enclosure')">An ORE-Atom doesn't support the 'atom:link' element
                rel="enclosure" attribute. </iso:assert>

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #2"
                test="@rel = 'self' or @rel = 'license' or @rel = 'alternate' or @rel = 'related'"
                >An ORE-Atom only supports the 'atom:link' element rel attribute like 'self',
                'alternate', 'license' and 'related'. </iso:assert>
        </iso:rule>
    </iso:pattern> - <iso:diagnostics>
        <iso:diagnostic id="NamespaceError_001">NamespaceError: Model Requirement #1 says that this
            Namespace MUST be present within this obligatory element; </iso:diagnostic>
        <iso:diagnostic id="NamespaceWarning_001">NamespaceError: Model Requirement #1 says that
            this Namespace SHOULD be present within this obligatory element; </iso:diagnostic>

        <iso:diagnostic id="ElementError_001">ElementError: Model Requirement #1 says that this
            element MUST have one and only one appearance in the document;</iso:diagnostic>
        <iso:diagnostic id="ElementError_002">ElementError: Model Requirement #2 says that this
            element MUST NOT have more than one appearance in the document </iso:diagnostic>
        <iso:diagnostic id="ElementError_003">ElementError: Model Requirement #3 says that this
            element is generally illegal or at this specific location in the document</iso:diagnostic>
        <iso:diagnostic id="ElementWarning_001">ElementWarning: Model Requirement #1 says that this
            element SHOULD be present</iso:diagnostic>

        <iso:diagnostic id="AttributeError_001">AttributeError: Model Requirement #1 says that this
            Attribute MUST be present within this obligatory element; </iso:diagnostic>
        <iso:diagnostic id="AttributeError_002">AttributeError: Model Requirement #2 says that this
            Attribute is present within this facultative element;</iso:diagnostic>
        <iso:diagnostic id="AttributeError_003">AttributeError: Model Requirement #2 says that this
            Attribute is illegal within this element;</iso:diagnostic>
        <iso:diagnostic id="AttributeWarning_001">AttributeWarning: Model Requirement #1 says that
            this attribute SHOULD be present</iso:diagnostic>

        <iso:diagnostic id="DataError_001">DataError: Data Requirement #1 says that a Value MUST be
            present;</iso:diagnostic>
        <iso:diagnostic id="DataError_002">DataError: Data Requirement #2 says that this Value MUST
            NOT have more than one appearance;</iso:diagnostic>
        <iso:diagnostic id="DataError_003">DataError: Data Requirement #3 says that this Value is
            prohibited;</iso:diagnostic>
        <iso:diagnostic id="DataWarning_001">Data Warning: Data Requirement #1 says that a Value is
            RECOMMENDED to be present;</iso:diagnostic>
    </iso:diagnostics>
    <iso:pattern id="EntryId">
        <iso:p>All basic atom entry id checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_001" see="ModelRequirements #1" test="atom:id"
                >Missing 'atom:entry' 'atom:id' element. Please provide a single 'atom:id' element
                and its value! </iso:assert>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(../atom:entry/atom:id[.=current()/atom:id]) = 1">Id <iso:value-of
                    select="atom:id[.=current()/atom:id]"/> is already definied <iso:value-of
                    select="count(../atom:entry/atom:id[.=current()/atom:id]) -1 "/> times </iso:assert>
            <iso:report test="count(../atom:entry/atom:id[.=current()/atom:id]) > 1">Id
                    <iso:value-of select="atom:id[.=current()/atom:id]"/>is already definied
                    <iso:value-of select="count(../atom:entry/atom:id[.=current()/atom:id]) -1"
                />times</iso:report>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:entry/atom:id">

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="normalize-space(.)">Empty value 'atom:entry' atom:id element </iso:assert>
            <iso:report test="not(normalize-space(.))">ORE-Atom 'atom:entry' 'atom:id' element
                without value.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(../atom:id) = 1">An ORE-Atom 'atom:entry' MUST have one and only one
                'atom:id' element. [RFC 4287, sec.4.1.2] </iso:assert>
            <iso:report test="not(count(../atom:id) = 1)">Incorrect amount of 'atom:entry' 'atom:id'
                references: <iso:value-of select="count(../atom:id)"/>
            </iso:report>

            <iso:let name="URIAR" value="string(../atom:link[@rel='alternate']/@href)"/>

            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="../atom:id != $URIAR">The value of this 'atom:id' element MUST NOT be the URI
                of the aggregated resource (URI-AR) </iso:assert>
            <iso:report test="../atom:id = $URIAR">Error, the value of this 'atom:entry' 'atom:id'
                element is the same as the URI of the aggregated resource (URI-AR)</iso:report>


            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="not(../atom:id = ancestor::atom:id)"> An ORE-Atom 'atom:entry' MUST have only
                unique 'atom:id' element values. </iso:assert>
            <iso:report test="../atom:id = ancestor::atom:id">Error, 'atom:entry' has ambigious
                'atom:id' element values.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryTitle">
        <iso:p>All basic atom entry title checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="atom:title"
                >Missing 'atom:entry' 'atom:title' element. Please provide a single 'atom:title'
                element and its value!</iso:assert>
            <iso:report test="not(atom:title)">Missing 'atom:entry' 'atom:title'
            element.</iso:report>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:entry/atom:title">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(../atom:title) = 1">An ORE-Atom 'atom:entry' MUST have one and only one
                'atom:title' element. It should convey meaningfull title of the Aggregated Resource. </iso:assert>
            <iso:report test="not(count(../atom:id) = 1)">Incorrect amount of 'atom:entry'
                'atom:title' references: <iso:value-of select="count(../atom:title)"/>
            </iso:report>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="normalize-space(.)">Empty value 'atom:entry' 'atom:title' element, please
                provide a title for the 'atom:title' element value. </iso:assert>
            <iso:report test="not(normalize-space(.))">ORE-Atom 'atom:entry' 'atom:title' element
                without value.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryUpdated">
        <iso:p>All basic atom entry updated checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="atom:updated">Missing 'atom:entry' 'atom:updated' element. Please provide a
                single 'atom:updated' element and its value! [Use ISO8601 date format -
                'yyyy-MM-ddTHH:mm:ssZ']. It MUST convey the date-time of most recent update of the
                Atom-based Aggregated Resource.</iso:assert>
            <iso:report test="not(atom:updated)">Missing 'atom:entry' 'atom:updated'
            element.</iso:report>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:entry/atom:updated">

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="normalize-space(.)">Empty value 'atom:entry' 'atom:updated' element, please
                provide a date value for the modification date as an 'atom:updated' value. Use
                (ISO8601 date format - 'yyyy-MM-ddTHH:mm:ssZ'). It MUST convey the date-time of most
                recent update of the Atom-based Aggregated Resource. </iso:assert>
            <iso:report test="not(normalize-space(.))">ORE-Atom 'atom:entry' 'atom:updated' element
                without value.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(../atom:updated) = 1">An ORE-Atom 'atom:entry' MUST contain one and only
                one 'atom:updated' element. It should convey the date-time of the atom:entry element
                that conveys the Aggregated Resource.</iso:assert>
            <iso:report test="count(../atom:updated) > 1">Incorrect amount of 'atom:entry'
                'atom:updated' references: <iso:value-of select="count(../atom:updated)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryPublished">
        <iso:p>All basic atom entry published checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/atom:published">

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="normalize-space(.)">Warning! Empty value, 'atom:entry' has an 'atom:published'
                element, date-time creation of Aggregated Resource. </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:published) &lt;= 1">An ORE-Atom 'atom:entry' MUST NOT have
                more than one 'atom:published' element. </iso:assert>
            <iso:report test="count(../atom:published) > 1">Incorrect amount of 'atom:entry'
                'atom:published' references: <iso:value-of select="count(../atom:published)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntrySource">
        <iso:p>All basic atom entry source checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/atom:source">

            <iso:assert diagnostics="ElementWarning_001" see="Model Requirements #1" test="child::*"
                >Warning! Empty set, 'atom:entry' has an 'atom:source' element without child
                elements</iso:assert>
            <iso:report test="not(count(child::*) > 0)">An ORE-Atom 'atom:entry' 'atom:source' has
                NO 'atom:id', 'atom:title', 'atom:updated' and 'atom:author' element, which are
                mandatory. Optional look for other atom:feed elements.</iso:report>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:source) &lt;= 1">An ORE-Atom 'atom:entry' MUST NOT have more
                than one 'atom:source' element.</iso:assert>
            <iso:report test="count(../atom:source) > 1">Incorrect amount of 'atom:entry'
                'atom:source' references: <iso:value-of select="count(../atom:source)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntrySummary">
        <iso:p>All basic atom entry summary checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/atom:summary">

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="normalize-space(.)">Warning! Empty value, 'atom:entry' has an 'atom:summary'
                element</iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:summary) &lt;= 1">An ORE-Atom 'atom:entry' MUST NOT contain
                more than one 'atom:summary' element. It should convey meaningful summary about the
                Aggregated Resource. </iso:assert>
            <iso:report test="count(../atom:summary) > 1"> Incorrect amount of 'atom:entry'
                'atom:summary' references: <iso:value-of select="count(../atom:summary)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntrySubtitle">
        <iso:p>All basic atom entry subtitle checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:subtitle)">An ORE-Atom 'atom:entry' MUST NOT contain any
                'atom:subtitle' element. </iso:assert>
            <iso:report test="atom:subtitle">Error, illegal ORE-Atom 'atom:entry' 'atom:subtitle'
                element.</iso:report>

        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryRights">
        <iso:p>All basic atom entry rights checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/atom:rights">

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../atom:rights) &lt;= 1">An ORE-Atom 'atom:entry' MUST NOT contain
                not more than one 'atom:rights' element </iso:assert>
            <iso:report test="count(../atom:rights) > 1"> Incorrect amount of 'atom:entry'
                'atom:rights' references: <iso:value-of select="count(../atom:rights)"/>
            </iso:report>


            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="../atom:source/atom:rights or /atom:feed/atom:rights or ../atom:rights"
                >Warning, You SHOULD provide a copyrights value in 'atom:rights' for this ORE-Atom
                object in either 'atom:feed', 'atom:entry' or 'atom:entry/atom:source' elements
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryGenerator">
        <iso:p>All basic atom entry generator checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:generator)">An ORE-Atom 'atom:entry' MUST NOT contain any
                'atom:generator' elements </iso:assert>
            <iso:report test="atom:generator">Error, illegal ORE-Atom 'atom:entry' 'atom:generator'
                element.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryIcon">
        <iso:p>All basic atom entry icon checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:icon)">An ORE-Atom 'atom:entry' MUST not have any 'atom:icon'
                elements </iso:assert>
            <iso:report test="atom:icon">Error, illegal ORE-Atom 'atom:entry' 'atom:icon'
            element.</iso:report>
        </iso:rule>

    </iso:pattern>
    <iso:pattern id="EntryLogo">
        <iso:p>All basic atom entry logo checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:logo)">An ORE-Atom 'atom:entry' MUST NOT contain any 'atom:logo'
                elements </iso:assert>
            <iso:report test="atom:logo">Error, illegal ORE-Atom 'atom:entry' 'atom:logo'
            element.</iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryAuthor">
        <iso:p>All basic atom entry author checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/atom:author">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="child::*"
                >Empty sub elements, 'atom:entry' 'atom:author' element. Please provide at least a
                'atom:name' child element. An ORE-Atom 'atom:entry' element MAY have any number of
                'atom:author' elements. This SHOULD convey meaningful authorship information of the
                Aggregated Resource. Alternative provide a author value for this ORE-Atom object in
                either 'atom:feed' or 'atom:entry/atom:source' elements. </iso:assert>
            <iso:report test="not(count(child::*) > 0)">An ORE-Atom 'atom:entry' 'atom:author' has
                NO 'atom:name' element, this MUST have one 'atom:name' and optional an 'atom:uri'
                and 'atom:email' child element.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(atom:name) = 1">An ORE-Atom 'atom:entry' 'atom:author' element MUST have
                one and only one 'atom:name' element. It should convey the meaningful authorship
                information of the Aggregation Resource. </iso:assert>
            <iso:report test="not(count(atom:name) = 1)">Incorrect amount of ORE-Atom 'atom:entry'
                'atom:author' 'atom:name' references: <iso:value-of select="count(atom:name)"/>
            </iso:report>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="string(atom:name)">Empty value, in ORE-Atom 'atom:name'. Please provide a
                'atom:name' value for the 'atom:author' element. </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #1"
                test="count(atom:uri) &lt;= 1">An ORE-Atom 'atom:author' element MUST NOT have
                more than one 'atom:uri' element. </iso:assert>
            <iso:report test="count(atom:uri) > 1">Multiple ORE-Atom 'atom:entry' 'atom:author'
                'atom:uri' references <iso:value-of select="count(atom:uri)"/>
            </iso:report>


            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(atom:email) &lt;= 1">An ORE-Atom 'atom:author' element MUST NOT have
                more than one 'atom:email' element. </iso:assert>
            <iso:report test="count(atom:email) > 1">Multiple ORE-Atom 'atom:entry' 'atom:author'
                'atom:email' references <iso:value-of select="count(atom:email)"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryContributor">
        <iso:p>All basic atom entry contributor checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/atom:contributor">

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="child::*"
                >Empty sub elements, 'atom:entry' 'atom:contributor' element. Please provide at
                least a 'atom:name' child element. An ORE-Atom 'atom:entry' element MAY have any
                number of 'atom:contributor' elements. This SHOULD convey meaningful information for
                the Aggregation. Alternative provide a author value for this ORE-Atom object in
                either 'atom:feed' or 'atom:entry/atom:source' elements. </iso:assert>
            <iso:report test="not(count(child::*) > 0)">An ORE-Atom 'atom:entry' 'atom:contributor'
                has NO 'atom:name' element, this MUST have one 'atom:name' and optional an
                'atom:uri' and 'atom:email' child element.</iso:report>

            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1"
                test="count(atom:name) = 1">An ORE-Atom 'atom:entry' 'atom:contributor' element MUST
                have one and only one 'atom:name' element. It should convey the meaningful
                authorship information of the Aggregation Resource. </iso:assert>
            <iso:report test="not(count(atom:name) = 1)">Incorrect amount of ORE-Atom 'atom:entry'
                'atom:contributor' 'atom:name' references: <iso:value-of select="count(atom:name)"/>
            </iso:report>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="string(atom:name)">Empty value, in ORE-Atom 'atom:name'. Please provide a
                'atom:name' value for the 'atom:contributor' element. </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(atom:uri) &lt;= 1">An ORE-Atom 'atom:contributor' element MUST NOT
                have more than one 'atom:uri' element. </iso:assert>
            <iso:report test="count(atom:uri) > 1">Multiple ORE-Atom 'atom:entry' 'atom:contributor'
                'atom:uri' references <iso:value-of select="count(atom:uri)"/>
            </iso:report>


            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(atom:email) &lt;= 1">An ORE-Atom 'atom:contributor' element MUST NOT
                have more than one 'atom:email' element. </iso:assert>
            <iso:report test="count(atom:email) > 1">Multiple ORE-Atom 'atom:entry'
                'atom:contributor' 'atom:email' references <iso:value-of select="count(atom:email)"
                />
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryCategory">
        <iso:p>All basic atom entry category checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/atom:category">

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #2"
                test="count(../atom:category[ @term='http://www.openarchives.org/ore/terms/Aggregation' ] ) &lt;= 1"
                >An ORE-Atom 'atom:entry' MUST NOT contain more than one 'atom:category' with term
                attribute value of 'http://www.openarchives.org/ore/terms/Aggregation' and with
                attribute label='Aggregation'.</iso:assert>
            <iso:report
                test="count(../atom:category[ @term='http://www.openarchives.org/ore/terms/Aggregation' ] ) > 1"
                >Error, incorrect amount 'atom:entry' 'atom:category' with term attribute value of
                'http://www.openarchives.org/ore/terms/Aggregation' and with attribute
                label='Aggrigation'.</iso:report>
        </iso:rule>
        <iso:rule
            context="/atom:feed/atom:entry/atom:category[ @scheme='http://www.openarchives.org/ore/terms/' ]">

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #2"
                test="@term='http://www.openarchives.org/ore/terms/Aggregation'">An ORE-Atom
                'atom:entry''atom:category' with scheme attribute value of
                'http://www.openarchives.org/ore/terms/' MUST have a attribute
                term='http://www.openarchives.org/ore/terms/Aggregation'.</iso:assert>

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #2"
                test="@label='Aggregation'">An ORE-Atom 'atom:entry''atom:category' with term
                attribute value of 'http://www.openarchives.org/ore/terms/Aggregation' SHOULD have a
                attribute label='Aggregation'.</iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryLink">
        <iso:p>All basic atom entry link checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">
            <iso:assert diagnostics="ElementError_001" see="Model Requirements #1" test="atom:link"
                >An ORE-Atom 'atom:entry' MUST contain exactly one 'atom:link' with the attribute
                rel='alternate'. </iso:assert>
        </iso:rule>

        <iso:rule context="/atom:feed/atom:entry/atom:link">

            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="string(@href)">An ORE-Atom 'atom:link' element MUST contain one href
                attribute. </iso:assert>
            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="string(@rel)">An ORE-Atom 'atom:link' element MUST contain one rel attribute . </iso:assert>


            <iso:assert diagnostics="AttributeError_001" see="Model Requirements #1"
                test="count(../atom:link[ @rel='alternate' ]) = 1">An ORE-Atom 'atom:entry' MUST
                have one and only one 'atom:link' element with an attribute rel='alternate'. This
                link MUST convey the Aggregated Resource. The href attribute value must be the URI
                of the Aggregated Resource (URI-AR) </iso:assert>
            <iso:report test="count(../atom:link[ @rel='alternate' ]) > 1">Incorrect amount of link
                alternate references: <iso:value-of select="count(../atom:link[ @rel='alternate' ])"
                /> value: <iso:value-of select="string(../atom:link[@rel='alternate']/@href)"/>
            </iso:report>

            <iso:assert diagnostics="DataError_001" see="Data Requirements #1"
                test="../atom:link[ @rel='alternate' ]/@href">Empty value, 'atom:entry' has an
                'atom:link' with rel='alternate' attribute, but its href attribute has no value. The
                href attribute value must be the URI of the Aggregated Resource (URI-AR)
            </iso:assert>
        </iso:rule>

        <iso:rule context="/atom:feed/atom:entry/atom:link[ @rel='via' ]">

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #2"
                test="count(../atom:link[ @rel='via' ]) &lt;= 1">An ORE-Atom 'atom:entry' MUST
                NOT have more than one 'atom:link' element with an attribute of rel='via'. </iso:assert>
            <iso:report test="count(../atom:link[ @rel='via' ]) > 1">Incorrect amount of
                'atom:entry' 'atom:link' attribute 'via' references: <iso:value-of
                    select="count(../atom:link[ @rel='via' ])"/>exists: <iso:value-of
                    select="../atom:link[ @rel='via' ]"/>value: <iso:value-of
                    select="string(../atom:link[ @rel='via' ]/@href)"/>
            </iso:report>


            <iso:assert diagnostics="DataError_002" see="Data Requirements #2"
                test="../atom:link[ @rel='via' ]/@href">Empty value, 'atom:entry' has an 'atom:link'
                with rel='via' attribute, but its href attribute has no value. </iso:assert>

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="../atom:link[ @rel='via' ]/@type">Empty value, An ORE-Atom 'atom:link' 'via'
                element can e.g. contain the attribute type with the 'application/atom+xml' value. </iso:assert>

            <iso:let name="URIP" value="normalize-space(string(/atom:feed/atom:entry/atom:id))"/>
            <iso:let name="URIPA" value="normalize-space(string(../atom:link[ @rel='via' ]/@href))"/>

            <iso:assert diagnostics="AttributeError_003" see="Model Requirements #3"
                test="$URIPA != $URIP">An ORE-Atom 'atom:entry' MUST NOT have 'atom:link' element
                with a rel attribute of 'via' and the href attribute value <iso:value-of
                    select="$URIPA"/> of the this objects Aggregated Resource Proxy <iso:value-of
                    select="$URIP"/> but instead of another Aggregated Resource Proxy. </iso:assert>

        </iso:rule>


        <iso:rule context="/atom:feed/atom:entry/atom:link[ @rel='self' ]">

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #2"
                test="count(../atom:link[ @rel='self' ]) &lt;= 1">An ORE-Atom 'atom:entry' MUST
                NOT have more than one 'atom:link' element with a rel attribute of 'self' </iso:assert>
            <iso:report test="count(../atom:link[@rel='self']) > 1">Incorrect amount of 'atom:entry'
                'atom:link' attribute 'self' references: <iso:value-of
                    select="count(../atom:link[@rel='self'])"/>exists: <iso:value-of
                    select="../atom:link[@rel='self']"/>value: <iso:value-of
                    select="string(../atom:link[@rel='self']/@href)"/>
            </iso:report>

            <iso:assert diagnostics="DataError_002" see="Data Requirements #2"
                test="../atom:link[ @rel='self' ]/@href">Empty value, 'atom:entry' has an
                'atom:link' with rel='self' attribute, but its href attribute has no value. The href
                attribute value must be the URI of another Aggregated Resource thus, other than of
                the URI-AR </iso:assert>

            <iso:assert diagnostics="DataWarning_001" see="Data Requirements #1"
                test="../atom:link[ @rel='self' ]/@type">Empty value, An ORE-Atom 'atom:link' 'self'
                element can e.g. contain the attribute type with the 'application/atom+xml' value.</iso:assert>

        </iso:rule>

        <iso:rule context="/atom:feed/atom:entry/atom:link">

            <iso:let name="URIAR"
                value="normalize-space(string(../atom:link[ @rel='alternate' ]/@href))"/>

            <iso:let name="URIR"
                value="normalize-space(string(/atom:feed/atom:link[ @rel='self']/@href))"/>

            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="$URIR != $URIAR">An ORE-Atom 'atom:entry' MUST NOT have 'atom:link' element
                with a rel attribute of 'self' and the href attribute value: <iso:value-of
                    select="$URIR"/> of the Aggregated Resource (<iso:value-of select="$URIAR"
            />).</iso:assert>
        </iso:rule>


        <iso:rule context="/atom:feed/atom:entry/atom:link[ @rel='related' ]">

            <iso:assert diagnostics="DataError_002" see="Data Requirements #2"
                test="../atom:link[ @rel='related' ]/@href">Empty value, 'atom:entry' has an
                'atom:link' with rel='related' attribute, but its href attribute has no value.
            </iso:assert>
        </iso:rule>
        <iso:rule context="/atom:feed/atom:entry/atom:link">

            <iso:assert diagnostics="AttributeError_002" see="Model Requirements #1"
                test="@rel = 'self' or @rel = 'via'or @rel = 'alternate' ">An ORE-Atom only support
                the 'atom:entry' 'atom:link' element rel attribute other than 'self', 'alternate'
                and 'via' . </iso:assert>

        </iso:rule>
        <iso:rule context="/atom:feed/atom:entry/atom:link[ @rel='via' ]/@href">

            <iso:let name="URIR" value="string(/atom:feed/atom:link[ @rel='self' ]/@href)"/>

            <iso:assert diagnostics="DataError_003" see="Data Requirements #3"
                test="not(normalize-space(.) = normalize-space($URIR))">This ' <iso:value-of
                    select="."/> ' MUST not be the URI of its own Resource Map ' <iso:value-of
                    select="string($URIR)"/> ' with which the Aggregated Resource tries to create a
                Lineage relationship </iso:assert>
        </iso:rule>

    </iso:pattern>
    <iso:pattern id="EntryContent">
        <iso:p>All basic atom entry extensible element checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry">

            <iso:assert diagnostics="ElementError_003" see="Model Requirements #3"
                test="not(atom:content)">An ORE-Atom 'atom:entry' MUST NOT contain any
                'atom:content' element. </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="EntryRdfExtension">
        <iso:p>All basic atom feed extension checks.</iso:p>
        <iso:rule context="/atom:feed/atom:entry/rdf:Description">

            <iso:let name="URIP" value="string(/atom:feed/atom:entry/atom:id)"/>
            <iso:let name="URIAR" value="string(/atom:feed/atom:entry/atom:link[@rel='self']/@href)"/>

            <iso:assert diagnostics="ElementWarning_001" see="Model Requirements #1" test="child::*"
                >Warning! Empty value 'rdf:Description' element. (corresponds the dc:rights of ORE
                model) </iso:assert>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../rdf:Description[@rdf:about='$URIP']) &lt;= 1">An ORE-Atom
                'atom:entry' MUST NOT contain more than one 'rdf:Description' element with as
                attribute value 'rdf:about' the URI-P of the Aggrigation Proxy. </iso:assert>

            <iso:report test="count(../rdf:Description) > 1">Incorrect amount of RDF Proxy
                references <iso:value-of select="count(../rdf:Description[@rdf:about='$URIP'])"/>
            </iso:report>

            <iso:assert diagnostics="ElementError_002" see="Model Requirements #2"
                test="count(../rdf:Description[@rdf:about='$URIAR']) &lt;= 1">An ORE-Atom
                'atom:entry' MUST NOT contain more than one 'rdf:Description' element with as
                attribute value 'rdf:about' the URI-AR of the Atom-based Aggregated Resource. </iso:assert>

            <iso:report test="count(../rdf:Description) > 1">Incorrect amount of RDF Aggregation
                Resource references <iso:value-of
                    select="count(../rdf:Description[@rdf:about='$URIAR'])"/>
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="Untested">
        <iso:title>Untested Assertions</iso:title>

        <iso:rule context="/">
            <iso:assert role="Untestable" test="true()">The document shall be maintainable</iso:assert>
            <iso:assert role="UnImplemented" test="true()">Not implemented</iso:assert>
        </iso:rule>
    </iso:pattern>
</iso:schema>
