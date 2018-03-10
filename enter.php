<?php

function debug_to_console( $data ) {
    $output = $data;
    if ( is_array( $output ) )
        $output = implode( ',', $output);

    echo "<script>console.log( 'Debug Objects: " . $output . "' );</script>";
}

// define variables and set to empty values
$nameErr = $emailErr = $genderErr = $websiteErr = "";
$condition= $matching= $keyn= $comment = $website = "";
$err=0;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["condition"])) {
    $condition= "-1";
    }else {
    $condition= $_POST["condition"];
  }

 if (empty($_POST["keyn"])) {
    $err = 1;
  } else {
    $keyn= ($_POST["keyn"]);
  }
 if (empty($_POST["match"])) {
    $err = 1;
  } else {
    $matching= $_POST["match"];
  }
}

if ($err==0){
$servername = "ams30.siteground.eu";
$username = "retrolan_gate";
$password = "sebastian1990";
$dbname = "retrolan_newkirk";
$conn = new mysqli($servername, $username, $password, $dbname);
$sql = 'Update products SET condition_own = '.$condition.' , matching = "'.$matching. '" WHERE itemId = '.$keyn ; 
debug_to_console($sql);
$result = $conn->query($sql);
}else{
debug_to_console('blabla');
}
$conn->close();

header("Location: /hello.php");
//    exit;
?>