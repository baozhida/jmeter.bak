<?xml version="1.0" encoding="GB2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
    <xsl:strip-space elements="*"/>


	<xsl:template name="detail">
		<xsl:variable name="allFailureCount" select="count(/testResults/*[attribute::s='false'])" />

		<xsl:if test="$allFailureCount > 0">
			<h2>Failure Detail</h2>

			<xsl:for-each select="/testResults/*[not(@lb = preceding::*/@lb)]">

				<xsl:variable name="failureCount" select="count(../*[@lb = current()/@lb][attribute::s='false'])" />

				<xsl:if test="$failureCount > 0">
					<h3><xsl:value-of select="@lb" /></h3>

					<table align="center" class="details" border="0" cellpadding="5" cellspacing="2" width="95%">
					<tr valign="top">
						<th>Response</th>
						<th>Failure Message</th>
					</tr>
				
					<xsl:for-each select="/testResults/*[@lb = current()/@lb][attribute::s='false']">
						<tr>
							<td><xsl:value-of select="@rc | @rs" /> - <xsl:value-of select="@rm" /></td>
							<td><xsl:value-of select="assertionResult/failureMessage" /></td>
						</tr>
					</xsl:for-each>
					
					</table>
				</xsl:if>

			</xsl:for-each>
		</xsl:if>
	</xsl:template>

    <xsl:template match="/testResults">
        <html lang="en">
        <head>
            <meta name="Author" content="shanhe.me"/>
            <title>JMeter Test Results</title>
            <style type="text/css"><![CDATA[
            
                * { margin: 0; padding: 0 }
				
				table.details tr th{
				    color: #ffffff;
					font-weight: bold;
					text-align:center;
					background:#2674a6;
					line-height:2em;					
				}
				
				table.details tr:nth-child(odd){background:#FFFFFF;border:1px solid #CCC;line-height:2em;}
				table.details tr:nth-child(even){background:#EDF3FE;border:1px solid #CCC;line-height:2em;}
				table.details td{border:1px solid black;}
				.Failure {
					font-weight:bold; color:red;
				}


                html{ width: 100%; height: 100%; background: #b4b4b4; font-size: 12px }
				body { width: 95%; height: 95%; margin: 0 auto; }
                table { border: none; border-collapse: collapse; table-layout: fixed;word-wrap:break-word;word-break:break-all; }
				#panel-wrap {position:relative;width: 100%;height: 100%;}
                td { vertical-align: baseline; font-size: 12px }
	
                #left-panel { position: absolute; left: 0; top: 0; bottom: 0; width: 30%; overflow: auto; background: #dee4ea }
                #left-panel li.navigation { font-weight: bold; cursor: default; color: #9da8b2; line-height: 18px; background-position: 12px 5px; background-repeat: no-repeat; padding: 0 0 0 25px; background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAkAAAAICAYAAAArzdW1AAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sDEBQqGbO7BEcAAAAdaVRYdENvbW1lbnQAAAAAAENyZWF0ZWQgd2l0aCBHSU1QZC5lBwAAAKRJREFUGNN1zM0KgkAYheF3RvtXSsGyWhRNaILS7bdt11W0KgJvoPwZp0UlBPUtz3nOJw7Hk7necv5dOA2Qaazo2vZP0LEt9olCVtqQROufKNmuqBuBNAYW4QzXGX6B0bDPcjGnMQYJ8Cg12U59oSzaUJQa4IUAXMclDHwAAn/MxPMw765FZd2QRgopBWmsKCrdfhXnS/4ZYElBXdyxewN008Y8AephLAkqz613AAAAAElFTkSuQmCC) }
                #left-panel li.success { color: #565b60 }
                #left-panel li.failure { color: red }
                #left-panel li { list-style: none; color: black; cursor: pointer }
                #left-panel li.selected { background-repeat: repeat-x; color: white; background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAUCAYAAABMDlehAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sDEBQxLTs5O2gAAAAdaVRYdENvbW1lbnQAAAAAAENyZWF0ZWQgd2l0aCBHSU1QZC5lBwAAAEdJREFUCNc1y7ERgEAMA0GNUhIyGqM2uqKgtyWZhE9v53A/7/A6D7BkMDNgy2AroB2wHTCZv5UMOgFLG1bvd7XBckBlwCXjA5wMOF5iOX/MAAAAAElFTkSuQmCC) }
                #left-panel div { line-height: 20px; background-position: 25px 3px; background-repeat: no-repeat; padding: 0 0 0 45px }
                #left-panel div.success { background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAOCAYAAADwikbvAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sDEBULEEc6wzcAAAAdaVRYdENvbW1lbnQAAAAAAENyZWF0ZWQgd2l0aCBHSU1QZC5lBwAAAiNJREFUKM99kktIVGEYhp/jzJl08lI6logp2Y2EFkbtaqlFROsWrlq4ioJWQRs37VoUVItWkYEVRGSBlhleCpywDEWxTEuxcURTZ6YzxzP/5WshCOHUt36f93kXnyMi5Lsnb4clI4s4fhkXzp5w8mWcfHBvfEpUxVdCUUU6lUPNHuD86cYtBQX5GhPrM7hRg7GaSDRg2vuUd90WuOPVsOyqy6FFo2yOQHlU1S9z9dZT+S/8I7GCLlkAN4eyAf56mnT6Fy1HLnGuuYa++MS/4e74qMRqfXLaJ9BpfnsrLC0m2BYuoqwUbj/+274JD43OEqmexwvW8NUKXnaZtVSS1pNtAAyOvyC6v48HnUNb4Z7PH8UtTlIQWA5tb2RhYY7kz3l2FleytJYg/qWb8t2KZ/0PN+1hgI6uEUr2jpHKpGlquExVaS0VbjUZL7WxaqIXK6ADQ0n9GNfv9XCttWnD/O57t0TKFklnF3g5fJ/seoaa2D4O1x0F4PlgO9oIftbgFgYMfLgjACGqj0vlsddoUnj+Kt/mxunq72RP+UGqYjWMTA7R+b6dUCSEGEF5hoJQip6BaFs4HJtCyRrKs6wHCovDip/kys0WWpovMpOYBCtoT2N9B5uzWG0Zid8gnFrVFEQDtBaUrxEgXBimaEeER2/uIiK4roPOaMRYjBKsFly3fOO3G06dETGCWIsYjckprMphtEKMAQtgsMYi1mJMQHJ6xvkDKQoyphCzkl0AAAAASUVORK5CYII=) }
                #left-panel div.failure { background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAOCAYAAADwikbvAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sDEBUJOEC5CU8AAAAdaVRYdENvbW1lbnQAAAAAAENyZWF0ZWQgd2l0aCBHSU1QZC5lBwAAAeVJREFUKM+NkDtok2EUhp8vl9ZLo/EyKI6KFgqCKC4OClrBWUQEcRRx1cGpk3WyInWrgoMZKkW8thYaEYQ0i7WC2ngrNDTERHJvkv/L/3//dxwc7F8jeOAsh/c973OOEhG61aPnaen7maXYt4MLZ4+pbppQt+F06jNH3QWOb8pxUs+SmJzjv83hxY8SVy3wNdtVneiHqe54IhLoB4/TUkyMyOrKj5yXoVtPZK02kLyYK7OnlqFWzgcCGtUC/YUJ3n5a/jd28tU7ORTN0myUA6Jms8bpWIa798elqzn1fokjThrpVBC3ETzNbYAuca59j/Hp+b/N869Tsk8tgVMCXQk+RlfQuk1/tMLMwzsSMCcm5zjhvoR2AdpF0GuwO4aqttS05ZSbZHhsBoAIwI83Cdkd/460XDAOG02d24MxvlR8dsUUh3f2UHaEtgdbWCHz4oZwcVCp66PP5FLhKjEc8DXaCMsNy8DYn/SnZ+L0hhWOb/F8yLs9fDtwk8j+VpqwrlC34PrgGEu2bhlYhZ1b8dncq3AMeBaUr/k6NUyk4ChKzu+N2hc6Bqody+WDG8g2fLatD7F3axjPgmvAtYJvIbouhhIRrl0ZktnkBGIt1gqeMXQ8D2MMiCIUCqFEsFhEQMSykCuqX0MzLAUJTzRsAAAAAElFTkSuQmCC) }
                #left-panel div.detail { display: none }
                #right-panel { position: absolute; right: 0; top: 0; bottom: 0; left: 30%; overflow: auto; background: white }
                #right-panel .group { font-size: 12px; font-weight: bold; line-height: 16px; padding: 0 0 0 18px; counter-reset: assertion; background-repeat: repeat-x; background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAQCAYAAADXnxW3AAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sDEBUkDq8pxjkAAAAdaVRYdENvbW1lbnQAAAAAAENyZWF0ZWQgd2l0aCBHSU1QZC5lBwAAADdJREFUCNdVxrERwDAMAzGK0v47eS6Z927SpMFBAAbkvSvnRk5+7K5cVfLMyN39bWakJAjA5xw9R94jN3tVhVEAAAAASUVORK5CYII=) }
                #right-panel .zebra { background-repeat: repeat; padding: 0 0 0 18px; background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAmCAYAAAAFvPEHAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9sDEBYWFlNztEcAAAAdaVRYdENvbW1lbnQAAAAAAENyZWF0ZWQgd2l0aCBHSU1QZC5lBwAAABdJREFUCNdjYKAtePv5338mBgYGBpoQAGy1BAJlb/y6AAAAAElFTkSuQmCC) }
				
                #right-panel .data { line-height: 19px; }
                #right-panel pre.data { white-space: pre }
                #right-panel tbody.failure { color: red }
                #right-panel td.key { min-width: 108px }
                #right-panel td.delimiter { min-width: 18px }
                #right-panel td.assertion:before { counter-increment: assertion; content: counter(assertion) ". " }
                #right-panel td.assertion { color: black }
                #right-panel .trail { border-top: 1px solid #b4b4b4 }
                
            ]]></style>
            <script type="text/javascript"><![CDATA[
            
                var onclick_li = (function() {
                    var last_selected = null;
                    return function(li) {
                        if( last_selected == li )
                            return;
                        if( last_selected )
                            last_selected.className = "";
                        last_selected = li;
                        last_selected.className = "selected";
                        document.getElementById("right-panel").innerHTML = last_selected.firstChild.nextSibling.innerHTML;
                        return false;
                    };
                })();
                
                var patch_timestamp = function() {
                    var spans = document.getElementsByTagName("span");
                    var len = spans.length;
                    for( var i = 0; i < len; ++i ) {
                        var span = spans[i];
                        if( "patch_timestamp" == span.className )
                            span.innerHTML = new Date( parseInt( span.innerHTML ) );
                    }
                };
                
                var patch_navigation_class = (function() {
                
                    var set_class = function(el, flag) {
                        if(el) {
                            el.className += flag ? " success" : " failure";
                        }
                    };
                
                    var traverse = function(el, group_el, flag) {
                        while(1) {
                            if(el) {
                                if(el.className == 'navigation') {
                                    set_class(group_el, flag);
                                    group_el = el;
                                    flag = true;
                                } else {
                                    var o = el.firstChild;
                                    o = o ? o.className : null;
                                    flag = flag ? (o == 'success') : false;
                                }
                                el = el.nextSibling;
                            } else {
                                set_class(group_el, flag);
                                break;
                            }
                        }
                    };
                    
                    return function() {
                        var o = document.getElementById("result-list");
                        o = o ? o.firstChild : null;
                        if(o)
                            traverse(o, null, true);
                    };
                })();
        
                window.onload = function() {
                    patch_timestamp();
                    patch_navigation_class();
                    var o = document.getElementById("result-list");
                    o = o ? o.firstChild : null;
                    o = o ? o.nextSibling : null;
                    if(o)
                        onclick_li(o);
                };

				function checkfailure() {
					if (document.getElementById("bt").innerHTML == "查看失败") {
						document.getElementById("bt").innerHTML = "查看全部";
						var trs = document.getElementsByTagName("table")[1].getElementsByTagName('tr');
						for( var i = 1; i < trs.length; i++ ) {
							var tr = trs[i];
							if( "Failure" != tr.className )
								tr.style.display = 'none';
						}
					}else if(document.getElementById("bt").innerHTML == "查看全部") {
						document.getElementById("bt").innerHTML = "查看失败";
						var trs = document.getElementsByTagName("table")[1].getElementsByTagName('tr');
						for( var i = 1; i < trs.length; i++ ) {
							var tr = trs[i];
							if( "Failure" != tr.className )
								tr.style.display = '';
						}
                    }
				};
        
            ]]></script>
        </head>
        <body>
			<h2>Summary</h2>
			<table  align="center" class="details" cellpadding="5" cellspacing="2" width="100%" >
				<tr valign="top">
					<th>执行总数</th>
					<th>成功数</th>
					<th>失败数</th>
					<th>成功率</th>
					<th>Average Time</th>
					<th>Min Time</th>
					<th>Max Time</th>
				</tr>
				<tr valign="top">
					<xsl:variable name="allCount" select="count(/testResults/*)" />
					<xsl:variable name="allFailureCount" select="count(/testResults/*[attribute::s='false'])" />
					<xsl:variable name="allSuccessCount" select="count(/testResults/*[attribute::s='true'])" />
					<xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />
					<xsl:variable name="allTotalTime" select="sum(/testResults/*/@t)" />
					<xsl:variable name="allAverageTime" select="$allTotalTime div $allCount" />
					<xsl:variable name="allMinTime">
						<xsl:call-template name="min">
							<xsl:with-param name="nodes" select="/testResults/*/@t" />
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="allMaxTime">
						<xsl:call-template name="max">
							<xsl:with-param name="nodes" select="/testResults/*/@t" />
						</xsl:call-template>
					</xsl:variable>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="$allFailureCount &gt; 0">Failure</xsl:when>
						</xsl:choose>
					</xsl:attribute>
					<td align="center">
						<xsl:value-of select="$allCount" />
					</td>
					<td align="center">
						<xsl:value-of select="$allSuccessCount" />
					</td>
					<td align="center">
						<xsl:value-of select="$allFailureCount" />
					</td>
					<td align="center">
						<xsl:call-template name="display-percent">
							<xsl:with-param name="value" select="$allSuccessPercent" />
						</xsl:call-template>
					</td>
					<td align="center">
						<xsl:call-template name="display-time">
							<xsl:with-param name="value" select="$allAverageTime" />
						</xsl:call-template>
					</td>
					<td align="center">
						<xsl:call-template name="display-time">
							<xsl:with-param name="value" select="$allMinTime" />
						</xsl:call-template>
					</td>
					<td align="center">
						<xsl:call-template name="display-time">
							<xsl:with-param name="value" select="$allMaxTime" />
						</xsl:call-template>
					</td>
				</tr>
			</table>
			<button class="button" id="bt" onclick="checkfailure()" style="float:right">查看失败</button>
			<h2>Pages</h2>
			<table align="center" class="details" cellpadding="5" cellspacing="2" width="100%">
				<tr valign="top">
					<th width="30%">URL</th>
					<th>执行总数</th>
					<th>失败</th>
					<th>成功率</th>
					<th>Average Time</th>
					<th>Min Time</th>
					<th>Max Time</th>
				</tr>
				<xsl:for-each select="/testResults/*[not(@lb = preceding::*/@lb)]">
					<xsl:variable name="label" select="@lb" />
					<xsl:variable name="count" select="count(../*[@lb = current()/@lb])" />
					<xsl:variable name="failureCount" select="count(../*[@lb = current()/@lb][attribute::s='false'])" />
					<xsl:variable name="successCount" select="count(../*[@lb = current()/@lb][attribute::s='true'])" />
					<xsl:variable name="successPercent" select="$successCount div $count" />
					<xsl:variable name="totalTime" select="sum(../*[@lb = current()/@lb]/@t)" />
					<xsl:variable name="averageTime" select="$totalTime div $count" />
					<xsl:variable name="minTime">
						<xsl:call-template name="min">
							<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="maxTime">
						<xsl:call-template name="max">
							<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
						</xsl:call-template>
					</xsl:variable>
					<tr valign="top">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="$failureCount &gt; 0">Failure</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<td align="left">
							<xsl:value-of select="$label" />
						</td>
						<td align="center">
							<xsl:value-of select="$count" />
						</td>
						<td align="center">
							<xsl:value-of select="$failureCount" />
						</td>
						<td align="center">
							<xsl:call-template name="display-percent">
								<xsl:with-param name="value" select="$successPercent" />
							</xsl:call-template>
						</td>
						<td align="center">
							<xsl:call-template name="display-time">
								<xsl:with-param name="value" select="$averageTime" />
							</xsl:call-template>
						</td>
						<td align="center">
							<xsl:call-template name="display-time">
								<xsl:with-param name="value" select="$minTime" />
							</xsl:call-template>
						</td>
						<td align="center">
							<xsl:call-template name="display-time">
								<xsl:with-param name="value" select="$maxTime" />
							</xsl:call-template>
						</td>
					</tr>
				</xsl:for-each>
			</table>

			<h2>ErrorDetail</h2>
			<div id="panel-wrap">
            <div id="left-panel">
                <ol id="result-list">
					<!-- 只把失败的生成html -->
                    <xsl:for-each select="*[attribute::s='false']">
                        <!-- group with the previous sibling -->
                        <xsl:if test="position() = 1 or @tn != preceding-sibling::*[1]/@tn">
                            <li class="navigation">Thread: <xsl:value-of select="@tn"/></li>
                        </xsl:if>
                        <li onclick="return onclick_li(this);">
                            <div>
                                <xsl:attribute name="class">
                                    <xsl:choose>
                                        <xsl:when test="@s = 'true'">success</xsl:when>
                                        <xsl:otherwise>failure</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:value-of select="@lb"/>
                            </div><div class="detail">
                                <div class="group">Sampler</div>
                                <div class="zebra">
                                    <table>
                                        <tr><td class="data key">Timestamp</td><td class="data delimiter">:</td><td class="data"><span class="patch_timestamp"><xsl:value-of select="@ts"/></span></td></tr>
                                        <tr><td class="data key">Time</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="@t"/> ms</td></tr>
                                        <tr><td class="data key">Latency</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="@lt"/> ms</td></tr>
                                        <tr><td class="data key">Sample Count</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="@sc"/></td></tr>
                                        <tr><td class="data key">Error Count</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="@ec"/></td></tr>
                                        <tr><td class="data key">Response Code</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="@rc"/></td></tr>
                                        <tr><td class="data key">Response Message</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="@rm"/></td></tr>
                                    </table>
                                </div>
                                <div class="trail"></div>
                                <xsl:if test="count(assertionResult) &gt; 0">
                                    <div class="group">Assertion</div>
                                    <div class="zebra">
                                        <table>
                                            <xsl:for-each select="assertionResult">
                                                <tbody>
                                                    <xsl:attribute name="class">
                                                        <xsl:choose>
                                                            <xsl:when test="failure = 'true'">failure</xsl:when>
                                                            <xsl:when test="error = 'true'">failure</xsl:when>
                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                    <tr><td class="data assertion" colspan="3"><xsl:value-of select="name"/></td></tr>
                                                    <tr><td class="data key">Failure</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="failure"/></td></tr>
                                                    <tr><td class="data key">Error</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="error"/></td></tr>
                                                    <tr><td class="data key">Failure Message</td><td class="data delimiter">:</td><td class="data"><xsl:value-of select="failureMessage"/></td></tr>
                                                </tbody>
                                            </xsl:for-each>
                                        </table>
                                    </div>
                                    <div class="trail"></div>
                                </xsl:if>
                                <div class="group">Request</div>
                                <div class="zebra">
                                    <table>
                                        <tr><td class="data key">Method/Url</td><td class="data delimiter">:</td><td class="data"><pre class="data"><xsl:value-of select="method"/><xsl:text> </xsl:text><xsl:value-of select="java.net.URL"/></pre></td></tr>
                                        <tr><td class="data key">Query String</td><td class="data delimiter">:</td><td class="data"><pre class="data"><xsl:value-of select="queryString"/></pre></td></tr>
                                    </table>
                                </div>
                                <div class="trail"></div>
                                <div class="group">Response</div>
                                <div class="zebra">
                                    <table>
                                        <tr><td class="data key">Response Data</td><td class="data delimiter">:</td><td class="data"><pre class="data"><xsl:value-of select="responseData"/></pre></td></tr>
                                    </table>
                                </div>
                                <div class="trail"></div>
                            </div>
                        </li>
                    </xsl:for-each>
                </ol>
            </div>
            <div id="right-panel"></div>
		</div>
        </body>
        </html>
    </xsl:template>


	<xsl:template name="min">
		<xsl:param name="nodes" select="/.." />
		<xsl:choose>
			<xsl:when test="not($nodes)">NaN</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$nodes">
					<xsl:sort data-type="number" />
					<xsl:if test="position() = 1">
						<xsl:value-of select="number(.)" />
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="max">
		<xsl:param name="nodes" select="/.." />
		<xsl:choose>
			<xsl:when test="not($nodes)">NaN</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$nodes">
					<xsl:sort data-type="number" order="descending" />
					<xsl:if test="position() = 1">
						<xsl:value-of select="number(.)" />
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="display-percent">
		<xsl:param name="value" />
		<xsl:value-of select="format-number($value,'0.00%')" />
	</xsl:template>

	<xsl:template name="display-time">
		<xsl:param name="value" />
		<xsl:value-of select="format-number($value,'0 ms')" />
	</xsl:template>

</xsl:stylesheet>