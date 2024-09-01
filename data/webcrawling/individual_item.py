import requests
from bs4 import BeautifulSoup
import json

# Function to extract product details
def extract_louis_vuitton_product(url):
    # Send an HTTP request to the product page
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36'
    }
    response = requests.get(url, headers=headers)
    
    # Parse the HTML content using BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Extract the product name
    name = soup.find('meta', {'property': 'og:title'})['content']
    
    # Extract the product description
    description_tag = soup.find('meta', {'name': 'description'})
    description = description_tag['content'] if description_tag else "No description available."
    
    # Extract the product price
    price_tag = soup.find('meta', {'property': 'product:price:amount'})
    price = price_tag['content'] if price_tag else "Price not available."
    
    # Extract product images
    image_tags = soup.find_all('meta', {'property': 'og:image'})
    images = [img['content'] for img in image_tags]

    # Create a dictionary with the extracted data
    product_details = {
        'name': name,
        'description': description,
        'price': price,
        'images': images
    }
    
    return product_details

# URL of the Louis Vuitton product page
url = "https://us.louisvuitton.com/eng-us/products/speedy-bandouliere-25-nvprod3160026v/M59273"

# Extract the product details
product_details = extract_louis_vuitton_product(url)

# Output the product details
print(json.dumps(product_details, indent=4))
