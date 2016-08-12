<!DOCTYPE html> 

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<html lang="en">

<jsp:include page="../fragments/headTag.jsp"/>


<body>
<script>
    $(function () {
        $("#date").datepicker({ dateFormat: 'yy/mm/dd'});
    });
</script>

<script src="/petdoctor/resources/js/moment.js"></script>

<script language="JavaScript">
    function validateForm() {
        var myform = document.forms[0];
        var date = myform.date.value;
        var description = myform.description.value;
        var errorMessagesId = "error_messages";
        //
        var valid = moment(date, 'YYYY/MM/DD',true).isValid();
        if(!valid){
            document.getElementById(errorMessagesId).innerHTML = "Please enter a valid Date in YYYY/MM/DD format";
        }

        if(valid) {
            if (description.length > 255 || description.length < 5) {
                document.getElementById(errorMessagesId).innerHTML = "Description must be between 5 and 255 chars";
                valid = false;
            }
        }
        return valid;
    }
</script>

<div class="container">
    <jsp:include page="../fragments/bodyHeader.jsp"/>
    <h2><c:if test="${visit['new']}">New </c:if>Visit</h2>

    <b>Pet</b>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Name</th>
            <th>Birth Date</th>
            <th>Type</th>
            <th>Owner</th>
        </tr>
        </thead>
        <tr>
            <td><c:out value="${visit.pet.name}"/></td>
            <td><joda:format value="${visit.pet.birthDate}" pattern="yyyy/MM/dd"/></td>
            <td><c:out value="${visit.pet.type.name}"/></td>
            <td><c:out value="${visit.pet.owner.firstName} ${visit.pet.owner.lastName}"/></td>
        </tr>
    </table>

    <span id="error_messages" style="color:red;">&nbsp;</span>

    <form:form modelAttribute="visit" onsubmit="return validateForm()">
        <div class="control-group">
            <label class="control-label">Date </label>

            <div class="controls">
                <form:input path="date"/>
                <span class="help-inline"><form:errors path="date"/></span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Description </label>

            <div class="controls">
                <form:input path="description"/>
                <span class="help-inline"><form:errors path="description"/></span>
            </div>
        </div>
        <div class="form-actions">
            <input type="hidden" name="petId" value="${visit.pet.id}"/>
            <button type="submit">Add Visit</button>
        </div>
    </form:form>

    <br/>
    <b>Previous Visits</b>
    <table style="width: 333px;">
        <tr>
            <th>Date</th>
            <th>Description</th>
        </tr>
        <c:forEach var="visit" items="${visit.pet.visits}">
            <c:if test="${!visit['new']}">
                <tr>
                    <td><joda:format value="${visit.date}" pattern="yyyy/MM/dd"/></td>
                    <td><c:out value="${visit.description}"/></td>
                </tr>
            </c:if>
        </c:forEach>
    </table>

</div>
<jsp:include page="../fragments/footer.jsp"/>
</body>

</html>
