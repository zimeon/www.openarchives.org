<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:ore="http://openarchives.org/ore/terms/"
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:grddl="http://www.w3.org/2003/g/data-view#" 
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <!-- atom-grddl.xsl  Version 0.3  March  2008 -->
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
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="atom:link[@rel='self']/@href"/>
                </xsl:attribute>
                <rdf:type>
                    <xsl:attribute name="rdf:resource">http://openarchives.org/ore/terms/ResourceMap</xsl:attribute>
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
                    <dc:creator>
                        <xsl:value-of select="atom:generator"/>
                    </dc:creator>
                </xsl:if>
                <xsl:if test="atom:generator/@uri">  
                    <dc:creator>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="atom:generator/@uri"/>
                        </xsl:attribute>
                    </dc:creator>
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
                    <atom:title>
                        <xsl:value-of select="atom:title"/>
                    </atom:title>
                </xsl:if>
                
                
               
                
                <xsl:for-each select="atom:author">
                    <atom:author rdf:parseType="Resource">
                        <xsl:if test="atom:name">
                            
                            <xsl:variable name="value"  as="xs:string" >
                                <xsl:value-of select ="atom:name"/>  
                            </xsl:variable>
                            
                            <xsl:variable name="result" >              
                                <xsl:call-template name="uri_validation">
                                    <xsl:with-param name="uri" select="$value"   />
                                </xsl:call-template>
                            </xsl:variable>
                            
                            <xsl:choose>
                                <xsl:when test ="$result!=''">
                                    <atom:name>
                                        <xsl:attribute name="rdf:resource">
                                            <xsl:value-of select="atom:name"/>
                                        </xsl:attribute>
                                    </atom:name>
                                </xsl:when>
                                <xsl:otherwise>
                                    <atom:name>
                                        <xsl:value-of select="atom:name"/>
                                    </atom:name>       
                                </xsl:otherwise>
                            </xsl:choose>        
                        </xsl:if>
                        
                        <xsl:if test="atom:uri">
                            
                            <atom:uri>
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of select="atom:uri"/>
                                </xsl:attribute>
                            </atom:uri>
                        </xsl:if>
                        
                        <xsl:if test="atom:email">
                            <atom:email>
                                <xsl:value-of select="atom:email"/>
                            </atom:email>
                        </xsl:if>
                        
                    </atom:author>   
                    
                </xsl:for-each>
                
              
                
                <xsl:for-each select="atom:entry/atom:link[@rel='alternate']">
                    <ore:aggregates> 
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@href" ></xsl:value-of>
                        </xsl:attribute>     
                    </ore:aggregates>
                </xsl:for-each>
                
               
                <xsl:if test="atom:logo" >
                    <atom:logo>
                        <xsl:value-of select="atom:logo"/>
                    </atom:logo>
                </xsl:if>
                <xsl:if test="atom:contributor" >
                    <atom:contributor>
                        <xsl:value-of select="atom:contributor"/>
                    </atom:contributor>
                </xsl:if>
                
                <xsl:if test="atom:icon" >
                    <atom:icon>
                        <xsl:value-of select="atom:icon"/>
                    </atom:icon>
                </xsl:if>
                <xsl:if test="atom:subtitle" >
                    <atom:subtitle>
                        <xsl:value-of select="atom:subtitle"/>
                    </atom:subtitle>
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
                    
                    <dc:rights>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@href"/>
                        </xsl:attribute>
                    </dc:rights>   
                    
                </xsl:for-each>
            </rdf:Description>
            
            <xsl:apply-templates select="child::*[namespace-uri() ='http://www.w3.org/1999/02/22-rdf-syntax-ns#']" />
            <xsl:apply-templates select="atom:entry/child::*[namespace-uri() ='http://www.w3.org/1999/02/22-rdf-syntax-ns#']" />
            
            <xsl:apply-templates select='atom:entry' mode="URI-P"/>
            <xsl:apply-templates select='atom:entry' mode="AR"/>
            <xsl:apply-templates select='atom:category' />
        </rdf:RDF>
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
            
            <xsl:if test="atom:updated">  
                <atom:updated>
                    <xsl:value-of select="atom:updated"/>
                </atom:updated>
            </xsl:if>
            
            <xsl:if test="atom:published">  
                <atom:published>
                    <xsl:value-of select="atom:published"/>
                </atom:published>
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
                        <atom:rights>
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="atom:rights" />
                            </xsl:attribute>
                        </atom:rights>
                    </xsl:when>
                    <xsl:otherwise>
                        <atom:rights>
                            <xsl:value-of select="atom:rights" />
                        </atom:rights>
                    </xsl:otherwise>
                </xsl:choose> 
            </xsl:if>
            
            
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
                <atom:title>
                    <xsl:value-of select="atom:title"/>
                </atom:title>    
            </xsl:if>
           
                <xsl:for-each select="atom:summary">
                <atom:summary>
                    <!--
                    <xsl:if test="contains(@type, 'xml') or contains(@type, 'html')">
                        <xsl:attribute name="rdf:parseType">
                            <xsl:text>Literal</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    -->
                    
                  
                    <xsl:apply-templates select="." mode="object"/>
                    
                </atom:summary>   
                </xsl:for-each>
          
            
            <xsl:if test="atom:contributor">
                <atom:contributor>
                    <xsl:value-of select="atom:contributor"/>
                </atom:contributor>    
            </xsl:if>
            
           
            
            <xsl:for-each select="atom:author">
                <atom:author rdf:parseType="Resource">
                    <xsl:if test="atom:name">
                        
                        <xsl:variable name="value"  as="xs:string" >
                            <xsl:value-of select ="atom:name"/>  
                        </xsl:variable>
                        
                        <xsl:variable name="result" >              
                            <xsl:call-template name="uri_validation">
                                <xsl:with-param name="uri" select="$value"   />
                            </xsl:call-template>
                        </xsl:variable>
                        
                        <xsl:choose>
                            <xsl:when test ="$result!=''">
                                <atom:name>
                                    <xsl:attribute name="rdf:resource">
                                        <xsl:value-of select="atom:name"/>
                                    </xsl:attribute>
                                </atom:name>
                            </xsl:when>
                            <xsl:otherwise>
                                <atom:name>
                                    <xsl:value-of select="atom:name"/>
                                </atom:name>       
                            </xsl:otherwise>
                        </xsl:choose>        
                    </xsl:if>
                    
                    <xsl:if test="atom:uri">
                        
                        <atom:uri>
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="atom:uri"/>
                            </xsl:attribute>
                        </atom:uri>
                    </xsl:if>
                    
                    <xsl:if test="atom:email">
                        <atom:email>
                            <xsl:value-of select="atom:email"/>
                        </atom:email>
                    </xsl:if>
                    
                </atom:author>   
            </xsl:for-each> 
            <xsl:apply-templates select="atom:link" mode="AR"/> 
        </rdf:Description>
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
        
        <xsl:if test="contains(@rel, 'self')">
            <ore:proxy>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
            </ore:proxy>  
            
        </xsl:if>
        
        
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