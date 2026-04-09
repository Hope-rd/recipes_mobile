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