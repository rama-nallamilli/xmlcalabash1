<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:err="http://www.w3.org/ns/xproc-error" xmlns:t="http://xproc.org/ns/testsuite" xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0" name="main">
<p:output port="result"/>

<p:parameters name="params">
  <p:with-param port="parameters" name="input1" select="'value1'">
    <p:empty/>
  </p:with-param>
  <p:input port="parameters">
    <p:inline>
      <c:param-set>
	<c:param name="input1" value="value2"/>
	<c:param name="input2" value="value1"/>
      </c:param-set>
    </p:inline>
  </p:input>
  <p:with-param port="parameters" name="param1" select="'value1'">
    <p:empty/>
  </p:with-param>
  <p:with-param port="parameters" name="input2" select="'value2'">
    <p:empty/>
  </p:with-param>
</p:parameters>

<!-- parameters are inherently unordered, but we want to force
     an order so that the test comes out right... -->

<p:identity name="pick1">
  <p:input port="source" select="/c:param-set/c:param[@name='input1']">
    <p:pipe step="params" port="result"/>
  </p:input>
</p:identity>

<p:identity name="pick2">
  <p:input port="source" select="/c:param-set/c:param[@name='input2']">
    <p:pipe step="params" port="result"/>
  </p:input>
</p:identity>

<p:identity name="pick3">
  <p:input port="source" select="/c:param-set/c:param[@name='param1']">
    <p:pipe step="params" port="result"/>
  </p:input>
</p:identity>

<p:wrap-sequence wrapper="c:param-set">
  <p:input port="source">
    <p:pipe step="pick1" port="result"/>
    <p:pipe step="pick2" port="result"/>
    <p:pipe step="pick3" port="result"/>
  </p:input>
</p:wrap-sequence>

</p:declare-step>