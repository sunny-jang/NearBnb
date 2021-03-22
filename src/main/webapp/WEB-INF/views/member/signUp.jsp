<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <c:set var="context" value="${pageContext.request.contextPath}/resources" />
<link href="${context}/html/css/park3.css" rel="stylesheet">
<%@ include file="../include/header.jsp" %>
<section>
    <div class="total">
        <h2>회원가입</h2>
        <hr>
        <center>
            <form>
                <table style="width: 600px;">
                    <tr>
                        <th>
                            아이디
                        </th>
                        <td>
                            <input type="text" style="width: 350px;" placeholder=" 아이디" class="p-2">
                        </td>
                        <td>
                            <input type="button" class="btn1" value="중복확인" >
                        </td>
                    </tr>
                    <tr>
                        <th>
                            비밀번호
                        </th>
                        <td>
                            <input type="password" style="width: 350px;" placeholder=" 비밀번호" class="p-2">
                        </td>
                    </tr>
                    <tr>
                        <th>
                            비밀번호 확인
                        </th>
                        <td>
                            <input type="password" style="width: 350px;" placeholder=" 비밀번호 확인" class="p-2">
                        </td>
                    </tr>
                    <tr>
                        <th>
                            이름
                        </th>
                        <td>
                            <input type="text" style="width: 350px;" placeholder=" 이름" class="p-2">
                        </td>
                    </tr>
                    <tr>
                        <th>
                            전화번호
                        </th>
                        <td>
                            <input type="text" style="width: 350px;" placeholder=" 01000000000" class="p-2">
                        </td>
                    </tr>
                    <tr>
                        <th>
                            이메일
                        </th>
                        <td>
                            <input type="email" style="width: 350px;" placeholder=" 이메일@이메일주소.com" class="p-2">
                        </td>
                        <td>
                            <input type="button" class="btn1" value="이메일 인증">
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td>
                            <input type="email" style="width: 350px;" placeholder=" 인증번호" class="p-2">
                        </td>
                        <td>
                            <input type="button" class="btn1" value="인증번호 확인">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <textarea readonly style="width: 600px; height: 100px; font-family: 나눔고딕; font-size: 3px;" class="p-2">
 1. 처리하는 개인정보 항목
    첫째, 회사는 입사지원, 입사와 관련된 문의 응답, 취업보호 대상자의 확인을 위해 아래와 같은 개인정보를 수집하고 있습니다.
    - 필수정보 : 성명, 확인용 비밀번호, 이메일 주소, 전화번호, 생년월일, 성별, 국적, 학력사항(학교명, 입학/졸업년월, 전공, 세부전공, 성적, 졸업구분), 경력사항(회사명, 직무, 직위, 부서명, 재직기간), 병역사항, 보훈사항(대상인 경우), 장애사항(대상인 경우)
    - 선택정보 : 경력사항(신입인 경우), 자격/어학사항(자격 종류, 등급, 점수, 취득일)

    둘째, 회사는 제휴제안 접수를 위하여 아래와 같은 개인정보를 수집하고 있습니다.
    - 필수정보 : 회사명, 제안자명, 전화번호, 이메일 주소
    - 선택정보 : 홈페이지 주소, 팩스번호

    셋째, 회사는 기업윤리상담센터 상담/신고하기 접수를 위하여 아래와 같은 개인정보를 수집하고 있습니다.
    - 필수정보 : 성명, 연락처, 이메일 주소, 처리결과 확인용 비밀번호 (익명 접수시에는 개인정보를 수집하지 않습니다.)

    넷째, 회사는 파트너스 라인 작성 및 접수를 위하여 아래와 같은 개인정보를 수집하고 있습니다.
    - 필수정보 : 제안자명, 파트너(업체)명, 연락처, 이메일 주소

    다섯째, 회사는 IR 미팅 접수를 위하여 아래와 같은 개인정보를 수집하고 있습니다.
    - 필수정보 : 신청인 및 방문자(동행인) 정보(회사명, 이름, 직책, 이메일, 연락처 )

    그리고 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
    - 이용자의 브라우저 종류 및 OS, 방문 기록(IP Address, 접속시간), 쿠키

2. 개인정보의 처리목적
    가. 입사전형 진행, 입사 지원서 수정, 합격 여부 확인, 입사 지원자와의 원활한 의사소통 (특정금융정보법에 따른 신원확인)
    나. 제휴제안 접수 및 처리결과 회신
    다. 기업윤리상담센터의 상담/신고 접수 및 처리결과 회신
    라. 파트너스 라인 접수 및 처리결과 회신
    마. IR 미팅 신청에 따른 본인확인 및 원활한 의사소통 경로 확보

3. 개인정보의 제3자 제공
    회사는 개인정보를 "2. 개인정보의 처리목적"에서 고지한 범위내에서 사용하며, 정보주체의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 개인정보를 외부에 공개하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.
    
    - 정보주체가 사전에 동의한 경우
    - 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우
    
    간혹 입사지원자에게 회사와 특수관계에 있는 회사(자회사, 계열사 등)에 입사제안을 드릴 수 있으며, 이 경우 반드시 사전에 입사지원자에게 개별 연락하여 동의 절차를 거친 후 입사지원서를 해당 회사로 이관합니다.

4. 개인정보의 처리 및 보유기간
    정보주체로부터 개인정보를 수집시에 동의받은 개인정보 보유/이용 기간 내에서 개인정보를 처리 및 보유하며, 원칙적으로 개인정보의 처리목적이 달성되면 지체 없이 파기합니다.
    
    다만 입사지원자의 개인정보는 회사의 인력풀에 5년간 보관되며 채용이 필요한 경우 해당 인력풀에서 상시채용을 위하여 이용됩니다. 입사지원자가 개인정보의 삭제를 원하는 경우 지체 없이 해당 정보를 삭제합니다.
                            </textarea>
                        </td>
                    </tr>                        
                    <tr>
                        <td colspan="3">
                            <input type="checkbox" style="float: right;"><p style="float: right;">개인정보 처리방침에 동의합니다 &nbsp;</p>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="center">
                            <input type="submit" value="회원가입" class="btn btn2">
                        </td>
                        <td></td>
                    </tr>
                </table>
            </form>
        </center>
    </div>
</section>
<%@ include file="../include/footer.jsp" %>