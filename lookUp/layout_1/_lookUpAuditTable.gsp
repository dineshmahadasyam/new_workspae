<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="utf-8" />
	    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	    <meta name="viewport" content="width=device-width, initial-scale=1" />
			<g:set var="appContext" bean="grailsApplication"/>    
	    <title></title>
	    
	    <link href="${resource(dir: '/css/layout_1_css', file: 'font-awesome.min.css')}" rel="stylesheet" type="text/css"></link>
	    <link href="${resource(dir: '/css/layout_1_css', file: 'bootstrap.min.css')}" rel="stylesheet" type="text/css"></link> 
	    <link href="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.pager.css')}" rel="stylesheet" type="text/css"></link> 
	    <link href="${resource(dir: '/js/layout_1_scripts/jquery-ui', file: 'jquery-ui.min.css')}" rel="stylesheet" type="text/css"></link>
	    <link href="${resource(dir: '/css/layout_1_css', file: 'fms-main.css')}" rel="stylesheet" type="text/css"></link>   
	
	    <!-- jQuery -->
	    <script src="${resource(dir: '/js/layout_1_scripts', file: 'jquery-1.11.3.min.js')}"></script>
	    
	    <!-- Tablesorter: required -->  
	     <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.metadata.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.pager.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'widget-columnSelector.js')}" ></script>
	    <script src="${resource(dir: '/js/layout_1_scripts/tablesorter', file: 'jquery.tablesorter.widgets.js')}" ></script>
	    
	    <script>
			var total = ${cdoCollectionSize};
			var htmlElementName= "IdAuditedTableName";
			var cdoClassName = "${cdoClassName}";
			var cdoClassAttributeName = "${cdoClassAttributeName}";
			var updateFields = "${updateFields}" ;
			var updateFieldsCdoName = "${updateFieldsCdoName}";
			var assocFieldCdoName = "${assocFieldCdoName}";
			var assocFieldValue = "${assocFieldValue}";
			var assocFields = "${IdAuditedTableName}";

			parent.lookupElementtoFocusOnCloseId = "IdAuditedTableName";
			
			function fnClose(lookUpId, selectedIndex) {
				var radios = document.forms["lookUpMainForm"].myLookUpValue			
				top.document.getElementById(htmlElementName).value= lookUpId;
				if (updateFieldsCdoName) {
					if (updateFieldsCdoName.indexOf("|") != -1) {
						var cdoNameArray = updateFieldsCdoName.split("|")
						var updateFieldsArray = updateFields.split("|")					
						for (var i =0;i<cdoNameArray.length;i++) {			
							var fieldToUpdate = document.getElementById(cdoNameArray[i]).value
								top.document.getElementById(updateFieldsArray[i]).value = fieldToUpdate
						}
					} else {
						var fieldToUpdate = document.getElementById(updateFieldsCdoName).value
						//alert (updateFields && updateFields.indexOf("|") != -1)
						if (updateFields && updateFields.indexOf("|") == -1) {
							top.document.getElementById(updateFields).value = fieldToUpdate
						}
						
					}
				}
				return parent.closeModal(htmlElementName);			
			}
			function fnReloadLookup() {
				var srchBatchId1 = document.forms["searchLookUpForm"].srchBatchId.value
				if (srchBatchId1) {
					top.document.getElementById(htmlElementName).value= srchBatchId1;				
					//top.document.getElementById("genericLookUpButton").click();
					parent.lookup(htmlElementName,cdoClassName,cdoClassAttributeName, assocFields , assocFieldCdoName, updateFields, updateFieldsCdoName);
				}
			}
			/*****************************************************/ 
			/* Script: Close the tablesorter ColumnSelector menu
			           when the window is resize or anything other 
			           then the ColumnSelectorButton is clicked
			*/ 
			/*****************************************************/ 

			  $( window ).resize(function() {
			      CloseColumnSelector();
			  });

			  // On any click on the page
			  $('*').click(function(e) {        
			      // If element is not the Column Selector
			      if(! $(e.target).closest(".columnSelectorWrapper").length ) {
			          CloseColumnSelector(); 
			      }
			  });

			  function CloseColumnSelector() {
			      // Uncheck menu checkbox which hides menu
			      $( "input[class*='columnSelectorcolSelect']" ).attr('checked', false);
			  }
			  
			  var parentBody = window.parent.document.body
			  $(parentBody).click(function(e){
			    CloseColumnSelector();
			  });
		</script>
	</head>
	<body style="background-image: none;">
		<div>
      		<div>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<g:else>
					<br>
				</g:else>
				<div class="fms_widget form-inline" style="padding-bottom:0;">
		 			<form name="searchLookUpForm" onSubmit="fnReloadLookup();return false;">
						<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):''}" />
					    <input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
      	
					 	<input type="hidden" name="htmlElementIdName" value="${htmlElementIdName}">
						<input type="hidden" name="cdoClassName" value="${cdoClassName}">
						<input type="hidden" name="cdoClassAttributeName" value="${cdoClassAttributeName}">
						<input type="hidden" name="updateFields" value="${updateFields}">
						<input type="hidden" name="updateFieldsCdoName" value="${updateFieldsCdoName}">
						<input type="hidden" name="assocFieldCdoName" value="${assocFieldCdoName}">
						<input type="hidden" name="assocFieldValue" value="${assocFieldValue}">
						<input type="hidden" name="assocFields" value="${assocFields}">		
						<div id="lookupSpinner" style="display:none">
							<img src="${resource(dir: '/images', file: 'spinner.gif')}" alt="Loading....." />
					    </div>		
       					<label class="control-label bold" id="SearchAgain_label" for="SearchAgain">You Search for:</label>
       					<input value="${htmlElementValue}" disabled="disabled" type="text" class="form-control" name="htmlElementValue" aria-labelledby="SearchAgain_label" aria-required="false" autofocus>
      				</form>          
    			</div>
     			<form name="lookUpMainForm">
	 				<div class="fms-iframe-table">
						<div id="BatchIDResults" class="fms_widget" style="padding-bottom:0;">
							<div class="fms_widget">
								<div class="row fms-col_selector_row">
									<div id="BatchIDResultsFound" class="col-xs-6 fms-results-found">${cdoCollectionSize} Results Found</div>
									 <div class="col-xs-6 fms-column-selector">
									
										 <div class="columnSelectorWrapper">
											 <input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1">
											<label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
											<div id="columnSelector" class="columnSelector">
												<!-- this div is where the column selector is added -->
											</div> 
										</div>
									</div>
								</div>
							</div>
							<div class="fms_table_wrapper0" >
								<table id="BatchIDResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="BatchIDResults_pager_info">
									<thead>
										 <tr role="row" class="tablesorter-headerRow" >
											<th data-columnselector="disable" class="{sorter: false}">Actions</th>
											<g:each in="${fields}" status="i" var="field">
										<%
											String[] fieldLabelTokens = org.apache.commons.lang.StringUtils.splitByCharacterTypeCamelCase(org.apache.commons.lang.StringUtils.capitalize(field.name));
											String fieldLabel = "";
											fieldLabelTokens.each() { labelTok -> fieldLabel += labelTok + " " };
											fieldLabel = fieldLabel.trim();
										%>
										<fmsui:sortableColumn property="${ field.name}" titleKey="${field.name}.label" title="${fieldLabel}" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
														params="[cdoClassName:params.cdoClassName, cdoClassAttributeName:params.cdoClassAttributeName, htmlElementIdName:params.htmlElementIdName, htmlElementValue:params.htmlElementValue, offset:params.offset, action:params.action, controller:params.controller, sort:params.sort, order:params.order]" />
										
					    				</g:each>
										</tr>
									</thead>
									<tfoot>				
									</tfoot>
	    							<tbody>
						    			<g:each in="${cdoCollection}" status="j" var="cdoObject">
											<tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
											<%String searchKeyMethodName = cdoClassAttributeName							
														searchKeyMethodName = "get"+new String(searchKeyMethodName.charAt(0)).toUpperCase().concat(searchKeyMethodName.substring(1, searchKeyMethodName.length()))	
														java.lang.reflect.Method searchKeyGetMeth = cdoObject.getClass().getMethod(searchKeyMethodName)
												 %>
												 <td nowrap="nowrap">
												 <button class="btn btn-primary btn-xs SelectBatchID" title="Click to select Value 1." data-dismiss="modal" data-reason="URL 1 - Value 1" onclick="return fnClose('${searchKeyGetMeth.invoke(cdoObject) }', ${j })">Select</button>&nbsp;${searchKeyGetMeth.invoke(cdoObject) }
												 <div style="display:none">	
												 	<input type="radio" name="myLookUpValue" value="${searchKeyGetMeth.invoke(cdoObject) }"/>&nbsp;&nbsp;${ searchKeyGetMeth.invoke(cdoObject) }
												 </div>
												<input type="hidden" id="${ searchKeyGetMeth.invoke(cdoObject) }" value="${ searchKeyGetMeth.invoke(cdoObject) }"/></td>
												<%  if (updateFieldsCdoName) {
													if (updateFieldsCdoName.indexOf("|") != -1) {
														java.util.ArrayList cdoFieldNamesList = updateFieldsCdoName.tokenize('|')
														
														cdoFieldNamesList.each { cdoAttributeName ->
															String searchKeyMethodName1 = cdoAttributeName							
															searchKeyMethodName1 = "get"+new String(searchKeyMethodName1.charAt(0)).toUpperCase().concat(searchKeyMethodName1.substring(1, searchKeyMethodName1.length()))	
															java.lang.reflect.Method searchKeyGetMeth1 = cdoObject.getClass().getMethod(searchKeyMethodName1)
														%>
														<input type="hidden" id="${ cdoAttributeName }" value="${ searchKeyGetMeth1.invoke(cdoObject) }"/>
													<%
														}
													} else {
													String searchKeyMethodName1 = updateFieldsCdoName
													searchKeyMethodName1 = "get"+new String(searchKeyMethodName1.charAt(0)).toUpperCase().concat(searchKeyMethodName1.substring(1, searchKeyMethodName1.length()))
													java.lang.reflect.Method searchKeyGetMeth1 = cdoObject.getClass().getMethod(searchKeyMethodName1)
												%>
												<input type="hidden" id="${ updateFieldsCdoName }" value="${ searchKeyGetMeth1.invoke(cdoObject) }"/>
											<%
													}
												}
												 %>	
												 <g:each in="${fields}" status="q" var="cdoField">
													<%String getMethodName = cdoField.getName()							
														getMethodName = "get"+new String(getMethodName.charAt(0)).toUpperCase().concat(getMethodName.substring(1, getMethodName.length()))	
														java.lang.reflect.Method getMeth = cdoObject.getClass().getMethod(getMethodName)
												 %>
													<td>
													<g:if test="${java.util.GregorianCalendar.class.equals(cdoField.getType())}">								
														<g:formatDate  format="yyyy-MM-dd"  date="${getMeth.invoke(cdoObject) }" />
													</g:if>
													<g:else>
														${getMeth.invoke(cdoObject) }
													</g:else>
													</td>
												</g:each>
												</tr>
										</g:each>
									</tbody>
								</table>
							</div>
						</div>
						<g:if test="${cdoCollectionSize > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
				           	<div id="SearchResultsPager" class="pager tablesorter-pager" style="padding-bottom:0; padding-top:0;">      
								<div class="pagination">
									<span class="right">
										<g:paginate total="${cdoCollectionSize}" params="[cdoClassName:params.cdoClassName,cdoClassAttributeName:params.cdoClassAttributeName,htmlElementIdName:params.htmlElementIdName, htmlElementValue:params.htmlElementValue]" />
									</span>
								</div>
							</div>
						</g:if>
					</div>
				</form>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	 $(document).ready(function() {

		    $(".tablesorter").tablesorter({
		        theme: 'blue',
		        initialized: function (table) {
		            $(".tablesorter").find(".show-disable-icon").removeClass("sorter-false");

		            var sortvar = getQueryVariable('sort');
		            var order = getQueryVariable('order');
		            var expr = 'tr[class="tablesorter-headerRow"] th[id^="' + sortvar + '"]';
		            var sortID = $(expr).attr('id');
		            if(sortvar!== -1) {
		                $("#" + sortID).removeClass("tablesorter-headerDesc");
		                $("#" + sortID).removeClass("tablesorter-headerAsc");
		                if (order === 'desc') {
		                    $("#" + sortID).addClass("tablesorter-headerDesc");
		                } else {
		                    $("#" + sortID).addClass("tablesorter-headerAsc");
		                }
		            }            
		        },

		        widgets: ['zebra', 'columnSelector'],
		        widgetOptions : {
		          columnSelector_container : $('#columnSelector'),
		          columnSelector_saveColumns: true,
		          columnSelector_mediaquery: false,      
		          columnSelector_layout : '<label><input type="checkbox">{name}</label>',
		          columnSelector_cssChecked : 'checked',


		          // Hide/Show columns based on viewport width 
		          columnSelector_mediaquery: true,
		          columnSelector_mediaqueryState: false,
		          columnSelector_mediaqueryName: 'Auto display columns: ',
		          columnSelector_priority : 'data-priority'
		        }
		    });

		    $(".show-disable-icon").click(function (evt) {
		        var columnRef = evt.currentTarget.id;
		        var url = $("#" + columnRef).attr("data-sorturl");
		        //var ad = Math.floor(Math.random() * 2);
		        
		        var newURL = url;// + "&sort=" + columnRef+"&order="+ad;
		        window.location = newURL;
		        
		    });

		    function getQueryVariable(variable) {
		        var query = window.location.search.substring(1);
		        var vars = query.split("&");
		        for (var i = 0; i < vars.length; i++) {
		            var pair = vars[i].split("=");
		            if (pair[0] == variable) {
		                return pair[1];
		            }
		        }
		        return -1;
		    }

		    });
		        
	</script>
</html>		
