<!DOCTYPE HTML>
<html lang = "pt-br">
<head>
   <title>Calculadora em PHP</title>
   <meta charset = "UTF-8">
</head>
<body>
   <h1>Calculadora em PHP - Alpine</h1>
   <table>
   <form action="" method="post" >
      <tr><td>Primeiro Numero</td><td><input name="num1" type="text"></td></tr>
      <tr><td>Segundo numero</td><td><input name="num2" type="text"></td></tr>
      <tr><td></td><td><input type="submit" name="operacao" value="+">     
      <input type="submit" name="operacao" value="-">     
      <input type="submit" name="operacao" value="*">     
      <input type="submit" name="operacao" value="/"></td></tr>
   </form> 
<?php
   if(isset($_POST['num1']))
   $a = $_POST['num1'];
   $b = $_POST['num2'];
   $op= $_POST['operacao'];

   if( !empty($op) ) {
      if($op == '+')
         $c = $a + $b;
      else if($op == '-')
         $c = $a - $b;
      else if($op == '*')
         $c = $a*$b;
      else
         $c = $a/$b;    
      echo "<tr><td></td><td><br><br><h3>O resultado da opera&ccedil;&atilde;o &eacute;: $c</h3></td></tr></table>";
   }
  }
?>
