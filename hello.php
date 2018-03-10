<?php
$servername = "ams30.siteground.eu";
$username = "retrolan_gate";
$password = "sebastian1990";
$dbname = "retrolan_newkirk";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
//echo "Connected successfully";
?>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {box-sizing:border-box}

/* Slideshow container */
.slideshow-container {
  max-width: 450px;
  position: relative;
  margin: auto;
}
.form-container {
  max-width: 450px;
  position: relative;
  margin: auto;
}

/* Hide the images by default */
.mySlides {
    display: none;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  margin-top: -22px;
  padding: 16px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor:pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}
</style>
</head>
<body>


<div class="slideshow-container">
<?php
	$sql = "SELECT images, itemId, query, title FROM products where images <> '' and condition_own = -1 LIMIT 1";
	$sql_count = "SELECT COUNT(*) FROM products where condition_own = -1";
	$result = $conn->query($sql);
	$result_q = $conn->query($sql_count);
if ($result->num_rows > 0) {
	$i = 0;
    while($row = $result->fetch_assoc()) {
    	$item_id = $row["itemId"];
    	$stri = $row["images"];
    	$i=$i+1;
    	//echo '<br>'.$i.'<br>'. $stri;
    	//print_r(explode(';', $stri, -1));
    	$pieces = explode(";", $stri);
    	//print_r($pieces);
    	$len =  sizeof($pieces);
    	//echo $len;
    	?>
    	<div><h2 style="text-align:left"><?php echo "Query: ".$row["query"]."</h2><h2 style='text-align:left'>"."Auction Title: ".$row["title"];?></h2></div>
    	
    	
<div class="form-container">
<form action="enter.php" method="post">
Condition: <input type="text" name="condition"><br>
<input type="radio" name="match" value="a">ack
<input type="radio" name="match" value="b">nak
<?php echo '<input type="hidden" name="keyn" value="'.$item_id. '">'; ?>
<span class="error"></span>
<input type="submit">
</form>
</div>


<?php
  	echo "<b> # ratings missing: " . $result_q->fetch_assoc()["COUNT(*)"] . "</b>";
    	for ($x = 0; $x < $len; $x++) {
    	echo '<div class="mySlides fade"><div class="numbertext">1 / 3</div><img src=https://i.ebayimg.com/images/g/'. $pieces[$x]. '/s-l1600.jpg style="width:100%"></div><div class="text">Caption Text</div>';
  //</div><div class="mySlides1"> <img src=https://i.ebayimg.com/images/g/'. $pieces[$x]. '/s-l1600.jpg style="width:100%"></div>';
	}
    }
} else {
    echo "0 results";
}
$conn->close();
?>
<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>
</div>




<script>
var slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1} 
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none"; 
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block"; 
  dots[slideIndex-1].className += " active";
}
</script>

</body>
</html> 
