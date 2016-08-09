<!DOCTYPE html> 

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">

<script language="JavaScript">

    function validateForm() {
        var myform = document.forms[0];
        var lastName = myform.lastName.value;
        if (lastName == null || lastName.trim() == "") {
            document.getElementById('error_messages').innerHTML = "Please enter Last name";
            //alert("Please enter Last name");
            return false;
        }
        if (lastName.length > 31 || lastName.length < 3) {
            document.getElementById('error_messages').innerHTML = "Last Name must be between 3 and 30 chars";
            //alert("Last Name must be less than or equal to 30 chars");
            return false;
        }

        var regex = /^[a-zA-Z0-9\s]*$/;
        if (!regex.test(lastName)) {
            document.getElementById('error_messages').innerHTML = "Last Name must contain only alphabets or spaces";
            return false;
        }

        return true;
    }
</script>

<jsp:include page="../fragments/headTag.jsp"/>

<body>
<div class="container">
    <jsp:include page="../fragments/bodyHeader.jsp"/>

    <h2>Find Owners</h2>

    <spring:url value="/owners.html" var="formUrl"/>
    <form:form modelAttribute="owner" action="${fn:escapeXml(formUrl)}" method="get" class="form-horizontal"
               id="search-owner-form">
        <fieldset>
            <div class="control-group" id="lastName">
                <label class="control-label">Last name </label>
                <form:input path="lastName" size="10" maxlength="80"/>
                <span class="help-inline" id="error_messages" style="color:red;"><form:errors path="*"/></span>
            </div>
            <br>
            <div class="form-actions">
                <br><br><br><br>
                <button type="submit" onclick="return validateForm()">find owner</button>
            </div>
        </fieldset>
    </form:form>

    <br/>
    <a href='#'>Add Owner</a>

    <jsp:include page="../fragments/footer.jsp"/>

</div>
</body>

</html>
