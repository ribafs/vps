<!DOCTYPE html>
<html lang="en">
<head>
  <title>Web Admin</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
  <h1>Web Admin</h1>
  <form action="admin.php" method="POST">
    <div class="form-group">
      <label for="dircake">Diretório do App:</label>
      <input type="text" class="form-control" id="dircake" value="/var/www/html/cake3" name="dircake">
    </div>
    <div class="form-group">
      <label for="database">Database name:</label>
      <input type="text" class="form-control" id="database" value="cake3" name="database">
    </div>
    <div class="form-group">
      <label for="username">Username:</label>
      <input type="text" class="form-control" id="username" value="root" name="username">
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="password" class="form-control" id="password" placeholder="Entre com a senha" value="" name="password">
    </div>
    <div class="form-group">
      <label for="script">Script SQL:</label>
      <input type="text" class="form-control" id="script" value="/var/www/html/web-admin/db.sql" name="script">
    </div>
    <div class="form-group">
      <label for="routes">Routes:</label>
      <input type="text" class="form-control" id="routes" value="/var/www/html/web-admin/routes.php" name="routes">
    </div>
    <div class="form-group">
      <label for="titulo">Título do Aplicativo:</label>
      <input type="text" class="form-control" id="titulo" value="Medbra" name="titulo">
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
</div>

</body>
</html>

