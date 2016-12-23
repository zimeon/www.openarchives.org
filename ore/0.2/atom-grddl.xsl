<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:ore="http://openarchives.org/ore/terms/"
    xmlns:owl="http://wwww.w3.org/2002/07/owl#"
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
  
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    
    <!-- atom-grddl.xsl  Version 0.12 Feb. 2008 -->
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
                        <xsl:value-of select="concat(atom:link[@rel='self']/@href,'#aggregation')"/>
                    </xsl:attribute>
                </ore:describes>
                <xsl:if test="atom:updated">  
                    <dcterms:modified>
                        <xsl:value-of select="atom:updated"/>
                    </dcterms:modified>
                </xsl:if>
                <xsl:if test="atom:author/atom:uri">
                  
                        <dc:creator>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="atom:author/atom:uri"/>
                        </xsl:attribute>
                    </dc:creator>
                </xsl:if>
                
                <xsl:if test="atom:author/atom:name">
                     
                      <xsl:variable name="value"  as="xs:string" >
                          <xsl:value-of select ="atom:author/atom:name"/>  
                      </xsl:variable>
             
                    <xsl:variable name="result" >              
                        <xsl:call-template name="uri_validation">
                            <xsl:with-param name="uri" select="$value"   />
                        </xsl:call-template>
                    </xsl:variable>
                    
                    <xsl:choose>
                        <xsl:when test ="$result!=''">
                         <dc:creator>
                         <xsl:attribute name="rdf:resource">
                             <xsl:value-of select="atom:author/atom:name"/>
                         </xsl:attribute>
                         </dc:creator>
                        </xsl:when>
                        <xsl:otherwise>
                            <dc:creator>
                                <xsl:value-of select="atom:author/atom:name"/>
                            </dc:creator>       
                            </xsl:otherwise>
                    </xsl:choose>        
                </xsl:if>
               
                <xsl:if test="atom:author/atom:email">
                    <dc:creator>
                        <xsl:value-of select="atom:author/atom:email"/>
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
                
                <xsl:if test="atom:created">  
                    <dc:created>
                        <xsl:value-of select="atom:created"/>
                    </dc:created>
                </xsl:if>
            </rdf:Description>
            
            <rdf:Description>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="concat(atom:link[@rel='self']/@href,'#aggregation')"/>
                </xsl:attribute>
                <rdf:type>
                    <xsl:attribute name="rdf:resource">http://openarchives.org/ore/terms/Aggregation</xsl:attribute>
                </rdf:type>    
                <xsl:for-each select="atom:entry/atom:link[@rel='alternate']">
                    <ore:aggregates> 
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of select="@href" ></xsl:value-of>
                        </xsl:attribute>     
                    </ore:aggregates>
                </xsl:for-each>
                <xsl:apply-templates select="child::atom:link"></xsl:apply-templates>
                <xsl:apply-templates select="child::*[namespace-uri() !='http://www.w3.org/2005/Atom']" />
                
            </rdf:Description>
            
            
            
            <xsl:apply-templates select='atom:entry'/>
        </rdf:RDF>
    </xsl:template>
    
    
    <!-- non atom elements of the feed are going to the Aggregation section -->
    <xsl:template match="atom:feed/child::*[namespace-uri()!='http://www.w3.org/2005/Atom']">
        <xsl:variable name="name" select="name()" />
        <xsl:variable name="ns" select="namespace-uri()"/>
        <xsl:variable name="value"  as="xs:string" >
            <xsl:value-of select ="text()"/>  
        </xsl:variable>
      
        <xsl:variable name="result" >              
            <xsl:call-template name="uri_validation">
                <xsl:with-param name="uri" select="$value"/>
            </xsl:call-template>
        </xsl:variable>
        
        
        <xsl:choose>
            <xsl:when test ="$result!=''">
                <xsl:element name="{$name}" namespace="{$ns}" >
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="."/>
                    </xsl:attribute> 
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{$name}" namespace="{$ns}"  >
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    
    
    <!--  template  is  controlling  what is copied from atom:entry  -->
    
    <xsl:template match="atom:entry">
        <rdf:Description>
            
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="atom:link[@rel='alternate']/@href"/>
            </xsl:attribute>
            <!-- 
            <rdf:type>
                <xsl:attribute name="rdf:resource">http://openarchives.org/ore/terms/AggregatedResource</xsl:attribute>
            </rdf:type> 
            -->
            <xsl:if test="atom:link[@rel='alternate']/@type">
                <dc:format>
                    <xsl:value-of select="atom:link[@rel='alternate']/@type"/>
                </dc:format>    
            </xsl:if>
            
            <xsl:apply-templates select="child::*[namespace-uri()='http://www.w3.org/2005/Atom']"/>  
            <xsl:apply-templates select="child::*[namespace-uri()!='http://www.w3.org/2005/Atom']"/>
            
            
        </rdf:Description>
    </xsl:template>
    
    <!-- From  all of the atom:elements of the entry  only atom:link is processed to rdf  -->   
    <xsl:template match ="atom:entry/child::*[namespace-uri()='http://www.w3.org/2005/Atom']">
        <xsl:apply-templates select="atom:link"/>  
    </xsl:template>  
    
    <!-- All non Atom properties of atom:entry are copied to
    AggregatedResource  properties -->
    
    <xsl:template match="atom:entry/child::*[namespace-uri()!='http://www.w3.org/2005/Atom']">
        <xsl:variable name="name" select="name()" />
        <xsl:variable name="ns" select="namespace-uri()"/>
        <xsl:variable name="value"  as="xs:string" >
            <xsl:value-of select ="text()"/>  
        </xsl:variable>
      
        <xsl:variable name="result" >              
            <xsl:call-template name="uri_validation">
                <xsl:with-param name="uri" select="$value"/>
            </xsl:call-template>
        </xsl:variable>
       
        
        <xsl:choose>
            <xsl:when test ="$result!=''">
                <xsl:element name="{$name}" namespace="{$ns}" >
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="."/>
                    </xsl:attribute> 
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{$name}" namespace="{$ns}"  >
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- atom:link is matched to ore semantic -->
    
    <xsl:template match="atom:link">
        <xsl:if test="contains(@rel, 'related')">
            <ore:analogousTo>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
            </ore:analogousTo>   
        </xsl:if>
        <xsl:if test="contains(@rel, 'via')">
            <ore:lineage>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
            </ore:lineage>   
        </xsl:if>
        
        <xsl:apply-templates/> 
        
        
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
