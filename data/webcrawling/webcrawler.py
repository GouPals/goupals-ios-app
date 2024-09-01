import os
import requests
from bs4 import BeautifulSoup
import pandas as pd
import json
import time

# Define the URL of the Louis Vuitton website
base_url = "https://www.louisvuitton.com"
category_url = "https://us.louisvuitton.com/eng-us/women/handbags/lv-icons/_/N-td4mq4v"  # Example category URL

# Headers to mimic a browser visit (User-Agent)
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36'
}

# Create directories to store data
if not os.path.exists('lv_images'):
    os.makedirs('lv_images')

# List to store all items data
items_data = []

# Function to scrape item details
def scrape_item(item_url):
    print(f"Scraping item URL: {item_url}")
    item_page = requests.get(item_url, headers=headers)
    soup = BeautifulSoup(item_page.content, 'html.parser')
    
    # Extract item details
    name = soup.find('h1', class_='title').get_text(strip=True)
    item_number = soup.find('span', class_='productCode').get_text(strip=True)
    price = soup.find('span', class_='priceValue').get_text(strip=True)
    availability_info = soup.find('span', class_='availabilityMessage').get_text(strip=True)
    
    print(f"Item found - Name: {name}, Item Number: {item_number}, Price: {price}, Availability: {availability_info}")
    
    # Extract images
    image_tags = soup.find_all('img', class_='primary-image')
    images = []
    for img in image_tags:
        img_url = img['src']
        images.append(img_url)
        
        # Download and save image
        img_data = requests.get(img_url).content
        img_name = f"{item_number}_{images.index(img_url)}.jpg"
        img_path = os.path.join('lv_images', img_name)
        with open(img_path, 'wb') as handler:
            handler.write(img_data)
        print(f"Image saved: {img_path}")
    
    # Save item data
    item_data = {
        'Name': name,
        'Item Number': item_number,
        'Price': price,
        'Availability': availability_info,
        'Images': images,
        'URL': item_url
    }
    items_data.append(item_data)
    print(f"Finished scraping item: {name}\n")

# Function to scrape a category page
def scrape_category_page(url):
    print(f"Scraping category page: {url}")
    category_page = requests.get(url, headers=headers)
    soup = BeautifulSoup(category_page.content, 'html.parser')
    
    # Find all items on the page
    item_links = soup.find_all('a', class_='product-title-link')
    
    print(f"Found {len(item_links)} items in the category.")
    
    for link in item_links:
        item_url = base_url + link['href']
        scrape_item(item_url)
        time.sleep(1)  # Adding delay to avoid overwhelming the server

# Start scraping the category page
scrape_category_page(category_url)

# Save the data to a CSV file
df = pd.DataFrame(items_data)
df.to_csv('lv_items_data.csv', index=False)
print("Data saved to lv_items_data.csv")

# Optionally, save the data as JSON
with open('lv_items_data.json', 'w') as json_file:
    json.dump(items_data, json_file, indent=4)
print("Data saved to lv_items_data.json")

print("Scraping completed.")
