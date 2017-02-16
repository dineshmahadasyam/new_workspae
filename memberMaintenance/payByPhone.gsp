<!DOCTYPE html>
<html>
<!-- JavaScript Includes -->
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
	<head>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"
		type="text/css">
	</head>
	<body>
	    <script src="jquery.min.js"></script>
	   
	    <div id="Payment-Gate" title="Payment Gateway" style="width: 100%; height: 500px;">
	        <iframe style="width: 100%; height: 100%;" name="PaymentIFrame" id="PaymentIFrame" class="PaymentIframeCls"></iframe>
	    </div>
	
	    <div id="PaymentFormDiv" style="visibility: hidden">
	        <form id="paymentForm" action="https://pay.instamed.com/default.aspx?id=caresource.test&Amount=${currentAccountBalance}&PatientFirstName=${firstName}" method="post" target="PaymentIFrame">
	            <input type="hidden" id="amount" name="Amount" value="${currentAccountBalance}" />
	            <input type="hidden" id="PatientFirstName" name="PatientFirstName" value="${firstName}" />
	            <input type="hidden" id="PatientLastName" name="PatientLastName" value="${lastName}" />
	
	            <input type="hidden" id="OrderNo" name="AdditionalInfo2" value= "${uuid}" />
	            <input type="hidden" id="UniqueConsumerId" name="AdditionalInfo3" value="${subscriberId}" />
	            <input type="hidden" id="Origin" name="AdditionalInfo4" value="${additionalInfo4}" />
	            <input type="hidden" id="TimeStamp" name="AdditionalInfo5" value="<g:formatDate format="MM/dd/yyyy" date="${currentDate}" />" />
	        </form>
	    </div>
	    <script type="text/javascript">
	        $('#paymentForm').submit();
	    </script>
	</body>
</html>