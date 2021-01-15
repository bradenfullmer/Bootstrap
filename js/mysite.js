// Get the modal
var modal = document.getElementById('myModal');

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img1 = document.getElementById('myImg1');
var img2 = document.getElementById('myImg2');
var img3 = document.getElementById('myImg3');
var img4 = document.getElementById('myImg4');
var img5 = document.getElementById('myImg5');
var img6 = document.getElementById('myImg6');
var img7 = document.getElementById('myImg7');
var img8 = document.getElementById('myImg8');
var img9 = document.getElementById('myImg9');
var img10 = document.getElementById('myImg10');
var img11 = document.getElementById('myImg11');
var modalImg = document.getElementById('img01');
var captionText = document.getElementById("caption");
var infoText = document.getElementById("info");
var descriptionText = document.getElementById("description");
img1.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2017 with Photoshop"
    descriptionText.innerHTML = "This is a piece of concept art from my Animated Music Video from GIMM 100 and 200. Even though the final piece did turn out different then this concept I really like this piece, and have even thought about going back and revising it into its own art piece."
}

img2.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2017 with Photoshop"
    descriptionText.innerHTML = "Like the previous piece, this one was also a piece of concept art. Although unlike the last one, I had decided to try and use color to see how that would work with my animation.I didn't care for it at this particular spot, but it did make me tthink about using color near the end of my animation as a way of calling back to this concept art."
}

img3.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2018 with Photoshop"
    descriptionText.innerHTML = "This was a big project early on in GIMM called the post-apocolyptic background painting. We had to take a photo of someplace in downtown Boise, ID and then transform it into an apocolyptic setting. It was a very difficult project for me, since I don't feel the most confident in my art skills. However in the end, I think it turned oout much better than I would've thought. This project taught me a lot on how to use Photoshop in a much more effective manner."
}

img4.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2018 with Photoshop"
    descriptionText.innerHTML = "This was a project that I worked on for a club that I'm a part of called Dev Club. The challenge was Alchemy, and I decided I wanted to try my hand at pixel art. So I created this piece which shows of an alchemists backroom and basement. I was really proud of how that turned out, and it has become one of my favorite pieces from my early years of college. "
}

img5.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2020 with Krita"
    descriptionText.innerHTML = "This was a logo that I had to make for a course in which we planned out a business. I went with making a fictional company and I decided to make the logo myself and this is what I created. Unlike most of the other 2D art on here, I used Krita instead of Photoshop for this piece."
}

img6.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = "Made in 2018 " + this.alt;
    infoText.innerHTML = "Made in 2018 with Photoshop"
    descriptionText.innerHTML = "This piece was another submission for Dev Club, with the challenge of Ocean. I wanted to try my hand at creating water with the sunlight coming through. For me this was quite a challenge because I wasn't exactly sure where to start. In the end I think I made something that was close to my original vision for the piece."
}

img7.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2018 with Photoshop"
    descriptionText.innerHTML = "This was another attempt at pixel art for a Dev Club submission, with the challenge of Platformer. I decided to make a Mario level since Mario is what most people think of when they think of platformers. This piece really showed me how tedious pixel art could be."
}

img8.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2018 with Photoshop"
    descriptionText.innerHTML = "Another submission that I had for Dev Club was this piece, in which the challenge was alien worlds with a bonus of building off of others concept designs. I created a world that appears to be very toxic and rocky. The concept designs I used were from H.R. Geiger's early designs of the alien hives for the 1979 movie Alien."
}

img9.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2019 with Blender"
    descriptionText.innerHTML = "This was my first experience with 3D modelling that I did over the summer to be better prepared for my 3D modelling class the next semester. I decided that I just wanted to do something simple so I made some stones and gave them an emission. From there I just messed around with metallic textures to get reflections and ended up with this as the final product. It helped me realize that 3D modelling was something that I shopuldn't feel nervous about."
}

img10.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2020 with Blender and Substance Painter"
    descriptionText.innerHTML = "This was a model that I made just to see if I could and how it might turn out. I started to use Subsatnce Painter and was feeling confident in my ability to create very realistic textures, with some help. Once I figured out how to get emission working in Substance Painter, all it took was playoing around with the settings to create something that I was very happy with."
}

img11.onclick = function () {
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
    infoText.innerHTML = "Made in 2020 with Blender and Substance Painter"
    descriptionText.innerHTML = "This was another model that I made just to see if I could. I had figured out how emission worked in Substance Painter so I decided to mess with the dirt settings for the texture, to give a feel of dirt and muck covering parts of the circle. I really enjoyed getting this piece finished because I was able to do it on my own, which helped me feel much more confident in my 3D modelling skills."
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function () {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }

}