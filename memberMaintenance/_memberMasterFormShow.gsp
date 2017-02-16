<%@ page import="com.perotsystems.diamond.bom.Member"%>
<%@ page import="com.perotsystems.diamond.bom.GroupType"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.States"%>

<g:javascript>
	function updateCity(e) {
		// The response comes back as a bunch-o-JSON
		var cities = eval("(" + e.responseText + ")")	// evaluate JSON

		if (cities) {
			var rselect = document.getElementById('city')

			// Clear all previous options
			var l = rselect.length

			while (l > 0) {
				l--
				rselect.remove(l)
			}

			// Rebuild the select
			for (var i=0; i < cities.length; i++) {
				var city = cities[i]
				var opt = document.createElement('option');
				opt.text = city
				opt.value = city
			  	try {
			    	rselect.add(opt, null) // standards compliant; doesn't work in IE
			  	}
		  		catch(ex) {
		    		rselect.add(opt) // IE only
		  		}
			}
		}
	}

	
	// This is called when the page loads to initialize city
	var zselect = document.getElementById('country.name')
	var zopt = zselect.options[zselect.selectedIndex]
	${remoteFunction(controller:"groupMaintenance", action:"ajaxGetCities", params:"'state=' + zopt.value", onComplete:"updateCity(e)")}

</g:javascript>

<style type="text/css">
	#editFields span{
		color:#0066CC;
	}
	#editFields label{
		width:160px;
		text-align:right;    	
	}
	#editFields input{
		width:140px;
		text-align:left;
	}
	#editFields formatDate{
		width:200px;
		text-align:left;
	}
	#editFields checkBox{
		width:10px;
		text-align:left;
 	}
</style>
<table id="editFields">
	<tr>
		<td>
				<label for="subscriberID-label"> <g:message
						code="memberMaster.subscriberID.label" default="Subscriber Id" />				
				</label>				
				<span class="property-value" aria-labelledby="subscriberID-label"><g:fieldValue bean="${memberMasterInstance}" field="subscriberID"/></span>
				
				<input type="hidden" name="memberDBID" value="${memberMasterInstance?.memberDBID}"/>
				<input type="hidden" name="subscriberID" value="${request.getParameter('subscriberID')}"/>
		</td>
		<td>						
						<label for="personNumber-label"> <g:message code="memberMaster.personNumber.label" default="Person Number" />
						
						<span class="property-value" aria-labelledby="personNumber-label">
						<g:fieldValue bean="${memberMasterInstance}" field="personNumber"/></span>

		</td>		
	</tr>
	<tr>
		
		<td>		
				<label for="lastName-label"> <g:message
						code="memberMaster.lastName.label" default="Last Name" />				
				</label>
				<span class="property-value" aria-labelledby="lastName-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="lastName"/></span>			

		</td>
	
		<td>
		
				<label for="firstName-label"> <g:message
						code="memberMaster.firstName.label"
						default="First Name" />
				</label>
					<span class="property-value" aria-labelledby="firstName-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="firstName"/></span>				
		
		</td>
	</tr>
		
	<tr>
		<td>
	
				<label for="middleInitial-label"> <g:message
						code="memberMaster.middleInitial.label" default="Middle Name" />

				</label>
				<span class="property-value" aria-labelledby="middleInitial-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="middleInitial"/></span>					
			
		</td>
		
			<td>
		
				<label for="namePrefix-label"> <g:message
						code="memberMaster.namePrefix.label" default="Salutation" />

				</label>
				<span class="property-value" aria-labelledby="namePrefix-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="namePrefix"/></span>					
		
		</td>
			<td>
	
				<label for="dob-label"> <g:message
						code="memberMaster.dob.label" default="DOB" />

				</label>
				
				<span class="property-value" aria-labelledby="dob-label">				
				<g:formatDate  format="MM-dd-yyyy"  date="${memberMasterInstance.dob}" />
				</span>	
				
			
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
	<td colspan="3">
			<h4>Contact Information<h4><hr>
		</td>
	</tr>

	<tr>
		<td>		
				<label for="address1-label"> <g:message
						code="memberMaster.address1.label" default="Address1" />

				</label>
								<span class="property-value" aria-labelledby="address1-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="primaryMemberAddress.address1"/></span>				
				
		</td>
		<td>
			
				<label for="address2-label"> <g:message
						code="memberMaster.address2.label" default="Address2" />
				</label>
								<span class="property-value" aria-labelledby="address2-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="primaryMemberAddress.address2"/></span>	
		
			</td>
		<td>
			
				<label for="city-label"> <g:message code="memberMaster.city.label"
						default="City" />
				</label>
						<span class="property-value" aria-labelledby="city-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="primaryMemberAddress.city"/></span>	
				
			
		</td>
	</tr>
	<tr>
		<td>
		
				<label for="state-label"> <g:message
						code="memberMaster.memberState.label" default="State" />

				</label>
				
				<span class="property-value" aria-labelledby="state-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="primaryMemberAddress.state"/></span>	
					
			
		</td>
		<td>
		
				<label for="zip-label"> <g:message
						code="memberMaster.zipCode.label" default="Zip Code" />

				</label>
				
					<span class="property-value" aria-labelledby="zip-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="primaryMemberAddress.zip"/></span>	
				
			
		</td>
		<td>
		
				<label for="county-label"> <g:message
						code="memberMaster.county.label" default="County" />
				</label>
				<span class="property-value" aria-labelledby="county-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="primaryMemberAddress.county"/></span>	
				
			
		</td>
	</tr>
	<tr>
		<td>
		
				<label for="country"> <g:message
						code="memberMaster.country.label" default="Country" />

				</label>
					<span class="property-value" aria-labelledby="country-label">				
				<g:fieldValue bean="${memberMasterInstance}" field="primaryMemberAddress.country"/></span>	
				
			
		</td>
	</tr>	
</table>