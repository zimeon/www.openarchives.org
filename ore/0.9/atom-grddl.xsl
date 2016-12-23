<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:ore="http://www.openarchives.org/ore/terms/"
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:grddl="http://www.w3.org/2003/g/data-view#" 
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <!-- atom-grddl.xsl  Version 0.9  May 2008 -->
    <!-- Crosswalk from ORE Atom serialization to RDF -->
    <!-- Los Alamos National Laboratary  -->
    <!-- Research Library -->
    <!-- Digital Library Research and Prototyping Team -->
    <!-- Author: Lyudmila Balakireva -->
    <!-- Email: ludab@lanl.gov -->
    <!--
        Use and distribution of this code are permitted under the terms of the <a
        href="http://creativecommons.org/licenses/by-nc-sa/2.5/"
        >Attribution-Noncommercial-Share Alike Creative Commons License</a>.
        
    -->
    
    <xsl:output method="xml" indent="yes" />
   
    <xsl:template match="atom:feed">
        <rdf:RDF>
            <!--  URI_R -->
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="atom:link[@rel='self']/@href"/>
                </xsl:attribute>
                <rdf:type>
                    <xsl:attribute name="rdf:resource">http://www.openarchives.org/ore/terms/ResourceMap</xsl:attribute>
                </rdf:type>    
                <ore:describes>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="atom:id"/>
                    </xsl:attribute>
                </ore:describes>
                <xsl:if test="atom:updated">  
                    <dcterms:modified>
                        <xsl:value-of select="atom:updated"/>
                    </dcterms:modified>
                </xsl:if>
                
                <xsl:if test="atom:generator">  
                    <dcterms:creator>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="atom:generator/@uri"/>
                        </xsl:attribute>
                    </dcterms:creator>
                </xsl:if>
                
                <xsl:if test="atom:rights" >
                    <xsl:variable name="value"  as="xs:string" >
                        <xsl:value-of select ="atom:rights"/>  
                    </xsl:variable>
                    
                    <xsl:variable name="result" >              
                        <xsl:call-template name="uri_validation">
                            <xsl:with-param name="uri" select="$value"   />
                        </xsl:call-template>
                    </xsl:variable>
                    
                    <xsl:choose>
                        <xsl:when test ="$result!=''">
                            <dc:rights>
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of select="atom:rights" />
                                </xsl:attribute>
                            </dc:rights>
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:rights>
                                <xsl:value-of select="atom:rights" />
                            </dc:rights>
                        </xsl:otherwise>
                    </xsl:choose> 
                </xsl:if>
                
              
            </rdf:Description>
            
            <!--  URI_A -->
            
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="atom:id"/>
                </xsl:attribute>
           
                <xsl:for-each select="atom:category">
                    <rdf:type>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@term" />
                        </xsl:attribute>  
                    </rdf:type>
                </xsl:for-each>
                
                <xsl:if test="atom:title" >
                    <dc:title>
                        <xsl:value-of select="atom:title"/>
                    </dc:title>
                </xsl:if>
                
                <xsl:if test="atom:subtitle" >
                    <dc:description>
                        <xsl:value-of select="atom:subtitle"/>
                    </dc:description>
                </xsl:if>
               
               
                <xsl:for-each select="atom:contributor">
                    <xsl:call-template name="contributor"/>    
                </xsl:for-each>
                
                <xsl:for-each select="atom:author">
                    <xsl:call-template name="author"/>
                 </xsl:for-each>
                 
                <!--  removed from model
                <xsl:if test="atom:logo" >
                    <foaf:logo>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="atom:logo" />
                        </xsl:attribute>
                    </foaf:logo>
                </xsl:if>
                 -->
                <xsl:if test="atom:icon" >
                    <foaf:logo>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="atom:icon" />
                        </xsl:attribute>
                    </foaf:logo>
                </xsl:if>
                
               
                <xsl:for-each select="atom:link[@rel='related']">
             
                    <ore:similarTo>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@href"/>
                        </xsl:attribute>
                    </ore:similarTo>   
              
                </xsl:for-each>
                
                <xsl:for-each select="atom:link[@rel='alternate']">
                    
                    <ore:isDescribedBy>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@href"/>
                        </xsl:attribute>
                    </ore:isDescribedBy>   
                    
                </xsl:for-each>
                <xsl:for-each select="atom:link[@rel='license']">
                    
                    <dcterms:rights>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@href"/>
                        </xsl:attribute>
                    </dcterms:rights>   
                    
                </xsl:for-each>
                
                <xsl:for-each select="atom:entry/atom:link[@rel='alternate']">
                    <ore:aggregates> 
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@href" ></xsl:value-of>
                        </xsl:attribute>     
                    </ore:aggregates>
                </xsl:for-each>
                
            </rdf:Description>
            
            <xsl:apply-templates select='atom:generator'/>
            <xsl:apply-templates select='atom:contributor'/>
            <xsl:apply-templates select='atom:author'/>
            <xsl:apply-templates select="child::*[namespace-uri() ='http://www.w3.org/1999/02/22-rdf-syntax-ns#']" />
            <xsl:apply-templates select="atom:entry/child::*[namespace-uri() ='http://www.w3.org/1999/02/22-rdf-syntax-ns#']" />
            
            <xsl:apply-templates select='atom:entry' mode="URI-P"/>
            <xsl:apply-templates select='atom:entry' mode="AR"/>
            <xsl:apply-templates select='atom:category' />
           
            <xsl:apply-templates select="atom:link[@rel='license']" />
            <xsl:apply-templates select="atom:link[@rel='alternate']" />
            <xsl:apply-templates select="atom:link[@rel='related']" />
            
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template name="link_expansion">
   
        <xsl:if test="(@type) or (@title) or (@hreflang) or (@length)" >
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:if test="@type" >
            <dc:format>
               <xsl:value-of select="@type"/>
            </dc:format>
            </xsl:if> 
            <xsl:if test="@hreflang" >
            <dc:language > 
                <xsl:value-of select="@hreflang"/>
            </dc:language>
            </xsl:if>
            <xsl:if test="@title" >
            <dc:title> 
                <xsl:value-of select="@title"/>
            </dc:title>
            </xsl:if>    
            <xsl:if test="@length" >
                <dcterms:extent> 
                    <xsl:value-of select="@length"/>
                </dcterms:extent>
            </xsl:if>    
        </rdf:Description>
            </xsl:if>
    
    </xsl:template>
    
    <xsl:template match="atom:link[@rel='license']">
        <xsl:call-template name="link_expansion"/>
    </xsl:template>
    
    <xsl:template match="atom:link[@rel='alternate']">
        <xsl:call-template name="link_expansion"/>
    </xsl:template> 
    
    <xsl:template match="atom:link[@rel='related']">
        <xsl:call-template name="link_expansion"/>
    </xsl:template> 
    <xsl:template match="atom:link[@rel='via']">
        <xsl:call-template name="link_expansion"/>
    </xsl:template> 
  
  
    <xsl:template name="person" >
        <xsl:if test="atom:uri">
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="atom:uri"/>
                </xsl:attribute>
                
                <xsl:if test="atom:name">
                    <foaf:name>
                        <xsl:value-of select="atom:name"/>
                    </foaf:name>
                </xsl:if>
                
                <xsl:if test="atom:email">
                    <foaf:mbox rdf:resource="mailto:{atom:email}"/>
                </xsl:if>
            </rdf:Description>  
        </xsl:if>   
    </xsl:template> 
    
    
    <xsl:template name="author" >
        <xsl:variable name="btest">
            <xsl:value-of select="atom:name"/>
        </xsl:variable>    
        
        <xsl:if test="(atom:name) or (atom:email) or (atom:uri) ">
            <xsl:if test="string-length($btest)>0" >
        <xsl:if  test="atom:uri">     
            <dcterms:creator>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="atom:uri"/>
                </xsl:attribute>
            </dcterms:creator>
        </xsl:if>
        
        <xsl:if test=" not(atom:uri)">
            <dcterms:creator rdf:parseType="Resource">
                <xsl:if test="atom:name">
                    <foaf:name>
                        <xsl:value-of select="atom:name"/>
                    </foaf:name>
                </xsl:if>
                <xsl:if test="atom:email">
                    <foaf:mbox rdf:resource="mailto:{atom:email}"/>
                </xsl:if>    
            </dcterms:creator>    
        </xsl:if>   
            </xsl:if>
        </xsl:if>
    </xsl:template> 
    
    <xsl:template name="contributor" >
    <xsl:if  test="atom:uri">     
        <dcterms:contributor>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="atom:uri"/>
            </xsl:attribute>
        </dcterms:contributor>
    </xsl:if>
    
    <xsl:if test=" not(atom:uri)">
        <dcterms:contributor rdf:parseType="Resource">
            <xsl:if test="atom:name">
                <foaf:name>
                    <xsl:value-of select="atom:name"/>
                </foaf:name>
            </xsl:if>
            <xsl:if test="atom:email">
                <foaf:mbox rdf:resource="mailto:{atom:email}"/>
            </xsl:if>    
        </dcterms:contributor>    
    </xsl:if>  
    </xsl:template> 
    
    <xsl:template match="atom:contributor">
        <xsl:call-template name="person"/>
    </xsl:template>   
    
    
    <xsl:template match="atom:author">
        <xsl:call-template name="person"/>
    </xsl:template>   
    
    <xsl:template match="atom:generator">
        <xsl:if test="@uri">
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="@uri"/>
                </xsl:attribute>
                
               
                    <foaf:name>
                        <xsl:value-of select="."/>
                    </foaf:name>
          
            </rdf:Description>      
        </xsl:if>
    </xsl:template>    
        
    
    <!-- non atom elements of the feed are going to the Aggregation section -->
    
    <xsl:template match="atom:feed/child::*[namespace-uri()='http://www.w3.org/1999/02/22-rdf-syntax-ns#']|@*">
    <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="atom:category">
        
    <rdf:Description>
        <xsl:attribute name="rdf:about">
            <xsl:value-of select="@term"/>
        </xsl:attribute>
        <rdfs:isDefinedBy>
        <xsl:attribute name="rdf:resource">
            <xsl:value-of select="@scheme"/>
        </xsl:attribute>
       </rdfs:isDefinedBy>
           <rdfs:label xml:lang="en-US"> 
            <xsl:value-of select="@label"/>
          </rdfs:label>
    </rdf:Description>
        
    </xsl:template>
    
    <!--  template  is  controlling  what is copied from atom:entry  -->
    
    
    <xsl:template mode="URI-P" match="atom:entry">
        <rdf:Description>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="atom:id"/>
            </xsl:attribute>
            
            <ore:proxyFor> 
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="atom:link[@rel='alternate']/@href" ></xsl:value-of>
                </xsl:attribute>     
            </ore:proxyFor>
            <ore:proxyIn> 
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="../atom:id" ></xsl:value-of>
                </xsl:attribute>     
            </ore:proxyIn>
            
            <!--  removed from model
            <xsl:if test="atom:updated">  
                <atomterms:updated>
                    <xsl:value-of select="atom:updated"/>
                </atomterms:updated>
            </xsl:if>
            
            <xsl:if test="atom:published">  
                <atomterms:published>
                    <xsl:value-of select="atom:published"/>
                </atomterms:published>
            </xsl:if>
            -->
            <!--  removed from model
            <xsl:if test="atom:rights" >
                <xsl:variable name="value"  as="xs:string" >
                    <xsl:value-of select ="atom:rights"/>  
                </xsl:variable>
                
                <xsl:variable name="result" >              
                    <xsl:call-template name="uri_validation">
                        <xsl:with-param name="uri" select="$value"   />
                    </xsl:call-template>
                </xsl:variable>
                
                <xsl:choose>
                    <xsl:when test ="$result!=''">
                        <atomterms:rights>
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="atom:rights" />
                            </xsl:attribute>
                        </atomterms:rights>
                    </xsl:when>
                    <xsl:otherwise>
                        <atomterms:rights>
                            <xsl:value-of select="atom:rights" />
                        </atomterms:rights>
                    </xsl:otherwise>
                </xsl:choose> 
                
                
            </xsl:if>
            
            -->
            <xsl:apply-templates select="atom:link" mode="URI-P"/>
            
        </rdf:Description>
       
    </xsl:template>
    
    <xsl:template mode="AR" match="atom:entry">
        <rdf:Description>
            
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="atom:link[@rel='alternate']/@href"/>
            </xsl:attribute>
           
            <xsl:for-each select="atom:category">
                <rdf:type>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="@term" />
                    </xsl:attribute>  
                </rdf:type>
            </xsl:for-each>
            <xsl:if test="atom:title">
                <dc:title>
                    <xsl:value-of select="atom:title"/>
                </dc:title>    
            </xsl:if>
           
                <xsl:for-each select="atom:summary">
                <dcterms:abstruct>
                    <!--
                    <xsl:if test="contains(@type, 'xml') or contains(@type, 'html')">
                        <xsl:attribute name="rdf:parseType">
                            <xsl:text>Literal</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    -->
                    
                  
                    <xsl:apply-templates select="." mode="object"/>
                    
                </dcterms:abstruct>   
                </xsl:for-each>
          
            <xsl:for-each select="atom:contributor">
                <xsl:call-template name="contributor"/>
               
            </xsl:for-each>
            
            <xsl:if test="not (atom:author)">
                
                <xsl:for-each select="../atom:author">
                    <xsl:call-template name="author"/>
                </xsl:for-each>
            </xsl:if>
            
            <xsl:for-each select="atom:author">
                <xsl:call-template name="author"/>
            </xsl:for-each>
            
            <xsl:for-each select="atom:link[@rel='alternate']">
             <xsl:if test="@type" >
                <dc:format>
                    <xsl:value-of select="@type"/>
                </dc:format>
             </xsl:if> 
            
            <xsl:if test="@hreflang" >
                <dc:language > 
                    <xsl:value-of select="@hreflang"/>
                </dc:language>
            </xsl:if>
            <xsl:if test="@title" >
                <dc:title> 
                    <xsl:value-of select="@title"/>
                </dc:title>
            </xsl:if>       
            </xsl:for-each>
            
            <xsl:apply-templates select="atom:link" mode="AR"/> 
        </rdf:Description>
        <xsl:apply-templates select='atom:contributor'/>
        <xsl:apply-templates select='atom:author'/>
        <xsl:apply-templates select="atom:link[@rel='via']" />
        <xsl:apply-templates select="atom:link[@rel='related']" />
        <xsl:apply-templates select='atom:category' />
    </xsl:template>
    
    
    
    <xsl:template match="*[not(*)]" mode="object">
        <xsl:copy-of select="@xml:lang"/>
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="*[*]" mode="object">
        <xsl:attribute name="rdf:parseType">Literal</xsl:attribute>
        <xsl:copy-of select="@xml:lang"/>
        <xsl:copy-of select="node()"/>
    </xsl:template>
    
    <!-- All non Atom properties of atom:entry are copied to
    AggregatedResource  properties -->
    
    <xsl:template match="atom:entry/child::*[namespace-uri()='http://www.w3.org/1999/02/22-rdf-syntax-ns#']|@*">
       
        <xsl:copy-of select="."/>
       
    </xsl:template>
    
    
    
    <!-- atom:link is matched to ore semantic -->
    
    
    <xsl:template mode="AR" match="atom:link">
       
        <xsl:if test="contains(@rel, 'related')">
            <ore:isAggregatedBy>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
            </ore:isAggregatedBy>   
        </xsl:if>
       
    </xsl:template>
    
    
    <xsl:template mode="URI-P" match="atom:link">   
        <xsl:if test="contains(@rel, 'via')">
            <ore:lineage>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
            </ore:lineage>  
            
        </xsl:if>
        
        <!--removed 
        <xsl:if test="contains(@rel, 'self')">
            <ore:proxy>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
            </ore:proxy>  
            
        </xsl:if>
        
        -->
    </xsl:template>
    
    <!-- This template is used  to determine if value of   property is URI or Literal. 
         if value has a space it is considered literal regadless of prefix.
         Also we are not expecting relative URIs
         It is based on simple  validation of scheme name of the URI: 
        consist of a letter followed by any combination of letters, digits, and 
        the plus ("+"), period ("."), or hyphen ("-") characters; and is terminated by a colon (":"). -->
    
    <xsl:template name="uri_validation">
        <xsl:param name="uri"  />
        <xsl:variable name="blanctest" >
            <xsl:choose>
            <xsl:when test="contains($uri, ' ')">
                <xsl:value-of select="' '"/>
            </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$uri"/> 
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="prefix"  >
            <xsl:if test="contains($blanctest, ':')">
                <xsl:value-of select="substring-before($uri, ':')"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="p">
            <xsl:choose>
                <xsl:when test="string-length($prefix)>0">
                    <xsl:value-of select="string-length($prefix)-1"/>   
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="string-length($prefix)"/>  
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:analyze-string select="$prefix"
            regex="^[a-zA-Z]{{1}}([A-z0-9/./+/-]{{{$p}}})" >
            <xsl:matching-substring>
                <xsl:value-of select="$prefix" />
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="''" />
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
   
    
</xsl:stylesheet>
