//.                    Note! everything here is just for reference purpose.

/* FOR COLORS:
 gradient: LinearGradient(
      colors: [
       Color(0xFFE55275),
       Color(0xFFA11F44),
      ],
    ),



void _selectCategories(){
if (categories.Quick){
filter by time;
} else if (categories.Nigeria){
filter by location;
} else if (categories.SmartSuggestion){
request user inputs,
return suggestions;
} else if (categories.Trending){
filter by most popular;
} else {
return recipes;
}
}


Stack(
  alignment: Alignment.topRight,
  children: [
  Image.network(
  recipe.url,
  width: double.infinity,
  fit: BoxFit.cover,
  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
  ),
  IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined)),
 ],
  ),
*/

// To import a random image from the internet, just click on the image and copy the image address.

// Next Step: 
// 1. Implement and connect the user experience in the categories section, make sure the categories are properly filtering the recipes and displaying the correct results.
// 2. In the recipe detail screen, find the best way to display the ingredients and preparation details, make sure they are easily accessible and user-friendly.
// 3. how to connect users(authors) to handle their own uploads
// 4. perhaps if video is a short type, play immediately in the catalog screen. e.g, <= 1 mins
// 5. Implement the search functionality, allowing users to search for recipes based on keywords, ingredients, or categories.
// 6. Implement the user profile section, allowing users to view and edit their profile information, see their saved recipes, and manage their uploads.
// 7. Implement the recipe upload functionality, allowing users to upload their own recipes with images, ingredients, and preparation steps.
// 8. add delay to scroll controller to prevent too many calls to the API when the user is scrolling throgh the catalog screen, perhaps using a debounce mechanism to limit the frequency of API calls and improve performance.

// create like a video player details screen, where users can watch the video and also reactto it, perhaps with a like button or a comment section. This could be a separate screen that is accessed when the user clicks on a video in the catalog screen, and it could include features such as video playback controls, a comment section, and a like button to allow users to interact with the content. Additionally, you could also consider implementing a feature that allows users to save their favorite videos for easy access later on.
// also wrap the video in the video detail screen with a gesture detector, so that when the user taps on the video, it will play in full screen mode, providing a more immersive viewing experience. This could be achieved by using the Navigator to push a new screen that contains the video player in full screen mode, and passing the video URL as an argument to the new screen. Additionally, you could also consider adding a feature that allows users to share the video with their friends or on social media platforms, further increasing engagement and visibility for the content.