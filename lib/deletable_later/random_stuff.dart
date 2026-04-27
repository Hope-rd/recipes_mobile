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
// 1. Test the videos, make sure they work and are properly integrated.
// 2. Implement and connect the user experience in the categories section, make sure the categories are properly filtering the recipes and displaying the correct results.
// 3. In the recipe detail screen, find the best way to display the ingredients and preparation details, make sure they are easily accessible and user-friendly. 