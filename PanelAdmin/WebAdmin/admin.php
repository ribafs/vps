<?php
if(isset($_POST['database'])){
    $dircake = $_POST['dircake'];
    $db = $_POST['database'];
    $user = $_POST['username'];
    $pass = $_POST['password'];
    $script = $_POST['script'];
    $routes = $_POST['routes'];
    $titulo = $_POST['titulo'];

echo '<pre>';
$last_line = system("composer create-project --prefer-dist cakephp/app:~3.0 $dircake", $retval);
echo '
</pre>
<hr />Last line of the output: ' . $last_line . '
<hr />Return value: ' . $retval;
    
}

