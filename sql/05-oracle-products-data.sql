-- ============================================
-- Insert 65 realistic products (IDs auto-generated)
-- ============================================

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Wireless Bluetooth Headphones',
    'High-quality over-ear wireless headphones with noise-cancellation and 20-hour battery life.',
    199.99,
    DATE '2023-01-15',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">250</weight>
               <dimensions unit="cm">20x18x5</dimensions>
               <manufacturer>SoundMax</manufacturer>
               <features>
                 <feature>Noise Cancellation</feature>
                 <feature>Bluetooth 5.0</feature>
                 <feature>20-hour battery</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Stainless Steel Water Bottle',
    'Eco-friendly 1-liter water bottle, keeps liquids cold for 24 hours and hot for 12 hours.',
    29.99,
    DATE '2023-02-01',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="grams">350</weight>
               <dimensions unit="cm">8x8x25</dimensions>
               <manufacturer>HydroPlus</manufacturer>
               <features>
                 <feature>Double-walled insulation</feature>
                 <feature>BPA-Free</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Ergonomic Office Chair',
    'Comfortable ergonomic chair with adjustable height, lumbar support, and breathable mesh back.',
    299.50,
    DATE '2023-03-10',
    XMLTYPE('<product>
               <category>Furniture</category>
               <weight unit="kg">15</weight>
               <dimensions unit="cm">70x70x120</dimensions>
               <manufacturer>ComfortWorks</manufacturer>
               <features>
                 <feature>Adjustable height</feature>
                 <feature>Lumbar support</feature>
                 <feature>Mesh back</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart LED Desk Lamp',
    'Adjustable LED desk lamp with touch control, multiple brightness levels, and USB charging port.',
    59.99,
    DATE '2023-03-25',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">1200</weight>
               <dimensions unit="cm">15x15x40</dimensions>
               <manufacturer>BrightLite</manufacturer>
               <features>
                 <feature>Touch control</feature>
                 <feature>Adjustable brightness</feature>
                 <feature>USB charging port</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Organic Cotton T-Shirt',
    'Soft and breathable organic cotton t-shirt, available in multiple colors and sizes.',
    24.99,
    DATE '2023-04-05',
    XMLTYPE('<product>
               <category>Clothing</category>
               <weight unit="grams">200</weight>
               <dimensions unit="cm">Varies</dimensions>
               <manufacturer>EcoWear</manufacturer>
               <features>
                 <feature>100% organic cotton</feature>
                 <feature>Unisex design</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Portable External SSD 1TB',
    'High-speed USB-C portable SSD with 1TB storage capacity, shock-resistant casing.',
    149.99,
    DATE '2023-04-15',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">50</weight>
               <dimensions unit="cm">10x7x1</dimensions>
               <manufacturer>DataSafe</manufacturer>
               <features>
                 <feature>USB-C interface</feature>
                 <feature>Shock-resistant</feature>
                 <feature>1TB capacity</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Adjustable Dumbbell Set',
    'Compact adjustable dumbbell set for home workouts, weights from 2.5kg to 20kg per dumbbell.',
    199.00,
    DATE '2023-05-01',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="kg">20</weight>
               <dimensions unit="cm">35x20x20</dimensions>
               <manufacturer>FitStrong</manufacturer>
               <features>
                 <feature>Adjustable weights</feature>
                 <feature>Compact design</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Coffee Maker 12-Cup',
    'Automatic drip coffee maker with programmable timer and thermal carafe.',
    89.99,
    DATE '2023-05-12',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">3</weight>
               <dimensions unit="cm">30x25x35</dimensions>
               <manufacturer>BrewMaster</manufacturer>
               <features>
                 <feature>Programmable timer</feature>
                 <feature>Thermal carafe</feature>
                 <feature>12-cup capacity</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Yoga Mat 6mm',
    'Eco-friendly non-slip yoga mat, 6mm thick, lightweight and easy to carry.',
    39.99,
    DATE '2023-05-20',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="grams">900</weight>
               <dimensions unit="cm">183x61x0.6</dimensions>
               <manufacturer>ZenFit</manufacturer>
               <features>
                 <feature>Non-slip</feature>
                 <feature>Eco-friendly material</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Gaming Mechanical Keyboard',
    'RGB backlit mechanical keyboard with customizable keys and durable switches.',
    129.99,
    DATE '2023-06-01',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">1100</weight>
               <dimensions unit="cm">45x15x3.5</dimensions>
               <manufacturer>GameTech</manufacturer>
               <features>
                 <feature>RGB backlight</feature>
                 <feature>Mechanical switches</feature>
                 <feature>Customizable keys</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Kettle 1.7L',
    'Stainless steel electric kettle with auto shut-off and 1.7-liter capacity.',
    49.99,
    DATE '2023-06-05',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">1.2</weight>
               <dimensions unit="cm">22x15x25</dimensions>
               <manufacturer>QuickBoil</manufacturer>
               <features>
                 <feature>Auto shut-off</feature>
                 <feature>1.7L capacity</feature>
                 <feature>Stainless steel</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Noise Cancelling Earbuds',
    'Compact wireless earbuds with active noise cancellation and 6-hour battery life.',
    129.99,
    DATE '2023-06-08',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">50</weight>
               <dimensions unit="cm">5x2x2</dimensions>
               <manufacturer>SoundMax</manufacturer>
               <features>
                 <feature>Noise cancellation</feature>
                 <feature>Wireless</feature>
                 <feature>6-hour battery</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Fitness Tracker Watch',
    'Smart fitness tracker with heart rate monitor, sleep tracking, and step counter.',
    79.99,
    DATE '2023-06-10',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="grams">35</weight>
               <dimensions unit="cm">4x4x1</dimensions>
               <manufacturer>FitTrack</manufacturer>
               <features>
                 <feature>Heart rate monitor</feature>
                 <feature>Sleep tracking</feature>
                 <feature>Step counter</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Laptop Backpack 20L',
    'Durable 20L laptop backpack with padded compartment and multiple pockets.',
    59.99,
    DATE '2023-06-12',
    XMLTYPE('<product>
               <category>Bags</category>
               <weight unit="kg">0.8</weight>
               <dimensions unit="cm">30x15x45</dimensions>
               <manufacturer>UrbanGear</manufacturer>
               <features>
                 <feature>Padded laptop compartment</feature>
                 <feature>Multiple pockets</feature>
                 <feature>Water-resistant</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Ceramic Dinnerware Set 16pcs',
    'Elegant 16-piece ceramic dinnerware set, microwave and dishwasher safe.',
    89.99,
    DATE '2023-06-15',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">12</weight>
               <dimensions unit="cm">Varies</dimensions>
               <manufacturer>HomeStyle</manufacturer>
               <features>
                 <feature>Microwave safe</feature>
                 <feature>Dishwasher safe</feature>
                 <feature>16 pieces</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Portable Projector HD',
    'Compact portable projector with HD resolution, HDMI/USB support, and built-in speaker.',
    229.99,
    DATE '2023-06-18',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="kg">1.5</weight>
               <dimensions unit="cm">20x15x10</dimensions>
               <manufacturer>ViewTech</manufacturer>
               <features>
                 <feature>HD resolution</feature>
                 <feature>HDMI/USB input</feature>
                 <feature>Built-in speaker</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Adjustable Standing Desk',
    'Height-adjustable standing desk for ergonomic workspace, 120x60 cm desktop.',
    399.00,
    DATE '2023-06-20',
    XMLTYPE('<product>
               <category>Furniture</category>
               <weight unit="kg">25</weight>
               <dimensions unit="cm">120x60x75-120</dimensions>
               <manufacturer>ComfortWorks</manufacturer>
               <features>
                 <feature>Height adjustable</feature>
                 <feature>Ergonomic design</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Wireless Mouse',
    'Ergonomic wireless mouse with adjustable DPI and long battery life.',
    29.99,
    DATE '2023-06-22',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">100</weight>
               <dimensions unit="cm">12x6x4</dimensions>
               <manufacturer>ClickTech</manufacturer>
               <features>
                 <feature>Ergonomic</feature>
                 <feature>Adjustable DPI</feature>
                 <feature>Wireless</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smartphone Tripod Stand',
    'Flexible tripod stand for smartphones, adjustable height and rotation.',
    34.99,
    DATE '2023-06-25',
    XMLTYPE('<product>
               <category>Photography</category>
               <weight unit="grams">450</weight>
               <dimensions unit="cm">10x10x40</dimensions>
               <manufacturer>PhotoFlex</manufacturer>
               <features>
                 <feature>Flexible legs</feature>
                 <feature>Adjustable height</feature>
                 <feature>360-degree rotation</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'LED Strip Light 5m',
    '5-meter RGB LED strip light with remote control and multiple lighting modes.',
    24.99,
    DATE '2023-06-28',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">300</weight>
               <dimensions unit="cm">500x1x0.3</dimensions>
               <manufacturer>BrightLite</manufacturer>
               <features>
                 <feature>RGB</feature>
                 <feature>Remote control</feature>
                 <feature>Multiple modes</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Bluetooth Speaker Portable',
    'Portable Bluetooth speaker with 12-hour battery, waterproof design, and clear bass.',
    79.99,
    DATE '2023-07-01',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">600</weight>
               <dimensions unit="cm">20x8x8</dimensions>
               <manufacturer>SoundMax</manufacturer>
               <features>
                 <feature>Waterproof</feature>
                 <feature>12-hour battery</feature>
                 <feature>Deep bass</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Air Purifier HEPA',
    'HEPA air purifier for small rooms, removes dust, pollen, and allergens effectively.',
    149.99,
    DATE '2023-07-03',
    XMLTYPE('<product>
               <category>Home Appliances</category>
               <weight unit="kg">4</weight>
               <dimensions unit="cm">30x20x50</dimensions>
               <manufacturer>PureAir</manufacturer>
               <features>
                 <feature>HEPA filter</feature>
                 <feature>Quiet operation</feature>
                 <feature>Compact size</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Thermostat',
    'WiFi-enabled smart thermostat compatible with Alexa and Google Home for energy saving.',
    199.99,
    DATE '2023-07-05',
    XMLTYPE('<product>
               <category>Home Automation</category>
               <weight unit="grams">300</weight>
               <dimensions unit="cm">10x10x3</dimensions>
               <manufacturer>EcoHome</manufacturer>
               <features>
                 <feature>WiFi control</feature>
                 <feature>Voice assistant support</feature>
                 <feature>Energy saving</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Stainless Steel Cookware Set 10pcs',
    'Premium 10-piece stainless steel cookware set with glass lids, dishwasher safe.',
    249.99,
    DATE '2023-07-08',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">15</weight>
               <dimensions unit="cm">Varies</dimensions>
               <manufacturer>CookPro</manufacturer>
               <features>
                 <feature>Dishwasher safe</feature>
                 <feature>Glass lids</feature>
                 <feature>10 pieces</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Running Shoes Men',
    'Lightweight running shoes for men, breathable mesh and cushioned sole for comfort.',
    89.99,
    DATE '2023-07-10',
    XMLTYPE('<product>
               <category>Footwear</category>
               <weight unit="grams">350</weight>
               <dimensions unit="cm">Varies</dimensions>
               <manufacturer>RunFast</manufacturer>
               <features>
                 <feature>Breathable mesh</feature>
                 <feature>Cushioned sole</feature>
                 <feature>Lightweight</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Wireless Charging Pad',
    'Qi-certified wireless charging pad for smartphones, fast charging compatible.',
    39.99,
    DATE '2023-07-12',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">150</weight>
               <dimensions unit="cm">10x10x1</dimensions>
               <manufacturer>ChargePro</manufacturer>
               <features>
                 <feature>Fast charging</feature>
                 <feature>Qi-certified</feature>
                 <feature>Compact design</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Laptop Cooling Pad',
    'Laptop cooling pad with dual fans, adjustable height, compatible with 15-17 inch laptops.',
    49.99,
    DATE '2023-07-15',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">700</weight>
               <dimensions unit="cm">35x25x3</dimensions>
               <manufacturer>CoolTech</manufacturer>
               <features>
                 <feature>Dual fans</feature>
                 <feature>Adjustable height</feature>
                 <feature>15-17 inch laptops</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Standing Fan',
    'Adjustable height electric fan with oscillation and 3-speed settings.',
    59.99,
    DATE '2023-07-18',
    XMLTYPE('<product>
               <category>Home Appliances</category>
               <weight unit="kg">5</weight>
               <dimensions unit="cm">40x40x120</dimensions>
               <manufacturer>AirFlow</manufacturer>
               <features>
                 <feature>Oscillation</feature>
                 <feature>3-speed settings</feature>
                 <feature>Adjustable height</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Noise Cancelling Headphones Pro',
    'Over-ear headphones with active noise cancellation, 30-hour battery life, and touch controls.',
    249.99,
    DATE '2023-07-20',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">280</weight>
               <dimensions unit="cm">20x18x6</dimensions>
               <manufacturer>SoundMax</manufacturer>
               <features>
                 <feature>Active noise cancellation</feature>
                 <feature>30-hour battery</feature>
                 <feature>Touch controls</feature>
               </features>
             </product>')
);


INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    '4K Ultra HD Monitor 27inch',
    '27-inch 4K Ultra HD monitor with IPS panel, 60Hz refresh rate, and adjustable stand.',
    329.99,
    DATE '2023-07-22',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="kg">4.5</weight>
               <dimensions unit="cm">61x36x5</dimensions>
               <manufacturer>ViewTech</manufacturer>
               <features>
                 <feature>4K Ultra HD</feature>
                 <feature>IPS panel</feature>
                 <feature>Adjustable stand</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart LED Light Bulb',
    'WiFi-enabled LED light bulb, adjustable brightness and color, compatible with Alexa and Google Home.',
    19.99,
    DATE '2023-07-25',
    XMLTYPE('<product>
               <category>Home Automation</category>
               <weight unit="grams">120</weight>
               <dimensions unit="cm">6x6x12</dimensions>
               <manufacturer>BrightLite</manufacturer>
               <features>
                 <feature>WiFi control</feature>
                 <feature>Color adjustable</feature>
                 <feature>Voice assistant compatible</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Toothbrush',
    'Rechargeable electric toothbrush with 3 brushing modes and 2-minute timer.',
    49.99,
    DATE '2023-07-26',
    XMLTYPE('<product>
               <category>Personal Care</category>
               <weight unit="grams">250</weight>
               <dimensions unit="cm">2x2x24</dimensions>
               <manufacturer>CleanSmile</manufacturer>
               <features>
                 <feature>Rechargeable</feature>
                 <feature>3 brushing modes</feature>
                 <feature>2-minute timer</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Portable Blender',
    'Compact portable blender for smoothies, USB rechargeable, 300ml capacity.',
    34.99,
    DATE '2023-07-27',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="grams">600</weight>
               <dimensions unit="cm">7x7x20</dimensions>
               <manufacturer>BlendPro</manufacturer>
               <features>
                 <feature>Portable</feature>
                 <feature>USB rechargeable</feature>
                 <feature>300ml capacity</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Pressure Cooker 6L',
    '6-liter electric pressure cooker with multiple cooking programs and stainless steel inner pot.',
    119.99,
    DATE '2023-07-28',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">6</weight>
               <dimensions unit="cm">30x30x35</dimensions>
               <manufacturer>CookPro</manufacturer>
               <features>
                 <feature>Multiple cooking programs</feature>
                 <feature>Stainless steel inner pot</feature>
                 <feature>6-liter capacity</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Wireless Gaming Controller',
    'Ergonomic wireless gaming controller with vibration feedback, compatible with PC and consoles.',
    59.99,
    DATE '2023-07-29',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">250</weight>
               <dimensions unit="cm">15x10x5</dimensions>
               <manufacturer>GameTech</manufacturer>
               <features>
                 <feature>Wireless</feature>
                 <feature>Vibration feedback</feature>
                 <feature>PC and console compatible</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Watch Fitness',
    'Smart watch with heart rate monitor, GPS tracking, notifications, and water-resistant design.',
    149.99,
    DATE '2023-07-30',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="grams">50</weight>
               <dimensions unit="cm">4x4x1</dimensions>
               <manufacturer>FitTrack</manufacturer>
               <features>
                 <feature>Heart rate monitor</feature>
                 <feature>GPS tracking</feature>
                 <feature>Water-resistant</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Memory Foam Pillow',
    'Ergonomic memory foam pillow for neck support, breathable and washable cover.',
    39.99,
    DATE '2023-08-01',
    XMLTYPE('<product>
               <category>Home</category>
               <weight unit="kg">1.2</weight>
               <dimensions unit="cm">60x40x12</dimensions>
               <manufacturer>SleepWell</manufacturer>
               <features>
                 <feature>Memory foam</feature>
                 <feature>Breathable cover</feature>
                 <feature>Washable</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Digital Kitchen Scale',
    'High-precision digital kitchen scale with tare function and 5kg capacity.',
    29.99,
    DATE '2023-08-02',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="grams">700</weight>
               <dimensions unit="cm">20x15x3</dimensions>
               <manufacturer>KitchenPro</manufacturer>
               <features>
                 <feature>Tare function</feature>
                 <feature>5kg capacity</feature>
                 <feature>Digital display</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Adjustable Dumbbells Pair',
    'Set of two adjustable dumbbells, 2.5kg to 25kg each, space-saving design.',
    249.99,
    DATE '2023-08-03',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="kg">25</weight>
               <dimensions unit="cm">35x25x20</dimensions>
               <manufacturer>FitStrong</manufacturer>
               <features>
                 <feature>Adjustable weight</feature>
                 <feature>Space-saving</feature>
                 <feature>Durable</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Yoga Mat Eco-Friendly',
    'Eco-friendly, non-slip yoga mat with 6mm thickness for comfortable practice.',
    29.99,
    DATE '2023-08-05',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="kg">1</weight>
               <dimensions unit="cm">183x61x0.6</dimensions>
               <manufacturer>ZenFlex</manufacturer>
               <features>
                 <feature>Non-slip</feature>
                 <feature>6mm thickness</feature>
                 <feature>Eco-friendly material</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Portable Coffee Maker',
    '12V portable coffee maker for travel and car use, compatible with capsules and ground coffee.',
    49.99,
    DATE '2023-08-06',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">1.2</weight>
               <dimensions unit="cm">25x12x10</dimensions>
               <manufacturer>BrewGo</manufacturer>
               <features>
                 <feature>12V car compatible</feature>
                 <feature>Capsules and ground coffee</feature>
                 <feature>Portable</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Wireless Keyboard',
    'Slim wireless keyboard with ergonomic design and long battery life.',
    39.99,
    DATE '2023-08-07',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">500</weight>
               <dimensions unit="cm">43x12x2</dimensions>
               <manufacturer>ClickTech</manufacturer>
               <features>
                 <feature>Wireless</feature>
                 <feature>Ergonomic</feature>
                 <feature>Long battery life</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Door Lock',
    'WiFi smart door lock with keypad, fingerprint access, and mobile app control.',
    199.99,
    DATE '2023-08-08',
    XMLTYPE('<product>
               <category>Home Automation</category>
               <weight unit="kg">2.5</weight>
               <dimensions unit="cm">25x8x6</dimensions>
               <manufacturer>SecureHome</manufacturer>
               <features>
                 <feature>Keypad and fingerprint access</feature>
                 <feature>WiFi enabled</feature>
                 <feature>Mobile app control</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Cordless Vacuum Cleaner',
    'Lightweight cordless vacuum cleaner with HEPA filter and 30-minute runtime.',
    129.99,
    DATE '2023-08-09',
    XMLTYPE('<product>
               <category>Home Appliances</category>
               <weight unit="kg">3</weight>
               <dimensions unit="cm">110x25x20</dimensions>
               <manufacturer>CleanAir</manufacturer>
               <features>
                 <feature>Cordless</feature>
                 <feature>HEPA filter</feature>
                 <feature>30-minute runtime</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Digital Camera Compact',
    '20MP compact digital camera with 5x optical zoom, image stabilization, and HD video recording.',
    199.99,
    DATE '2023-08-10',
    XMLTYPE('<product>
               <category>Photography</category>
               <weight unit="grams">350</weight>
               <dimensions unit="cm">10x6x4</dimensions>
               <manufacturer>PhotoPro</manufacturer>
               <features>
                 <feature>20MP sensor</feature>
                 <feature>5x optical zoom</feature>
                 <feature>HD video recording</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Grill Indoor',
    'Indoor electric grill with non-stick plates, temperature control, and drip tray.',
    89.99,
    DATE '2023-08-11',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">4.5</weight>
               <dimensions unit="cm">40x25x10</dimensions>
               <manufacturer>GrillMaster</manufacturer>
               <features>
                 <feature>Non-stick plates</feature>
                 <feature>Temperature control</feature>
                 <feature>Drip tray included</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Hair Trimmer',
    'Cordless hair trimmer with adjustable length combs and 60-minute battery life.',
    39.99,
    DATE '2023-08-12',
    XMLTYPE('<product>
               <category>Personal Care</category>
               <weight unit="grams">200</weight>
               <dimensions unit="cm">18x4x4</dimensions>
               <manufacturer>GroomPro</manufacturer>
               <features>
                 <feature>Adjustable combs</feature>
                 <feature>Cordless</feature>
                 <feature>60-minute battery</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Plug WiFi',
    'WiFi smart plug compatible with Alexa and Google Home, remote control via app.',
    19.99,
    DATE '2023-08-13',
    XMLTYPE('<product>
               <category>Home Automation</category>
               <weight unit="grams">150</weight>
               <dimensions unit="cm">6x6x4</dimensions>
               <manufacturer>SmartHome</manufacturer>
               <features>
                 <feature>WiFi enabled</feature>
                 <feature>Remote control</feature>
                 <feature>Voice assistant compatible</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Mini Fridge 50L',
    'Compact 50L mini fridge with adjustable thermostat, suitable for dorms or offices.',
    159.99,
    DATE '2023-08-14',
    XMLTYPE('<product>
               <category>Home Appliances</category>
               <weight unit="kg">12</weight>
               <dimensions unit="cm">50x45x85</dimensions>
               <manufacturer>CoolTech</manufacturer>
               <features>
                 <feature>50L capacity</feature>
                 <feature>Adjustable thermostat</feature>
                 <feature>Compact design</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Portable Air Conditioner',
    'Compact portable AC unit, 9000 BTU, with remote control and timer function.',
    299.99,
    DATE '2023-08-15',
    XMLTYPE('<product>
               <category>Home Appliances</category>
               <weight unit="kg">25</weight>
               <dimensions unit="cm">45x35x75</dimensions>
               <manufacturer>CoolAir</manufacturer>
               <features>
                 <feature>9000 BTU</feature>
                 <feature>Remote control</feature>
                 <feature>Timer function</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Cordless Electric Screwdriver',
    'Cordless electric screwdriver with multiple bits, rechargeable battery, LED light.',
    49.99,
    DATE '2023-08-16',
    XMLTYPE('<product>
               <category>Tools</category>
               <weight unit="grams">800</weight>
               <dimensions unit="cm">20x4x4</dimensions>
               <manufacturer>ToolPro</manufacturer>
               <features>
                 <feature>Multiple bits</feature>
                 <feature>LED light</feature>
                 <feature>Rechargeable</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Wireless Earbuds Pro',
    'True wireless earbuds with noise cancellation, 24-hour battery with charging case.',
    149.99,
    DATE '2023-08-17',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">50</weight>
               <dimensions unit="cm">2x2x3</dimensions>
               <manufacturer>SoundMax</manufacturer>
               <features>
                 <feature>Noise cancellation</feature>
                 <feature>Charging case</feature>
                 <feature>24-hour battery</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Gaming Chair Ergonomic',
    'High-back ergonomic gaming chair with adjustable armrests, lumbar support, and reclining.',
    229.99,
    DATE '2023-08-18',
    XMLTYPE('<product>
               <category>Furniture</category>
               <weight unit="kg">20</weight>
               <dimensions unit="cm">70x70x120</dimensions>
               <manufacturer>GameComfort</manufacturer>
               <features>
                 <feature>Ergonomic design</feature>
                 <feature>Adjustable armrests</feature>
                 <feature>Reclining backrest</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Water Bottle',
    'Water bottle with hydration tracker and LED reminder, 500ml capacity.',
    39.99,
    DATE '2023-08-19',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="grams">300</weight>
               <dimensions unit="cm">7x7x25</dimensions>
               <manufacturer>HydraTech</manufacturer>
               <features>
                 <feature>Hydration tracker</feature>
                 <feature>LED reminder</feature>
                 <feature>500ml capacity</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Rice Cooker 1.8L',
    '1.8-liter electric rice cooker with multiple cooking modes and keep warm function.',
    59.99,
    DATE '2023-08-20',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">3</weight>
               <dimensions unit="cm">25x25x20</dimensions>
               <manufacturer>CookPro</manufacturer>
               <features>
                 <feature>Multiple cooking modes</feature>
                 <feature>Keep warm function</feature>
                 <feature>1.8L capacity</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Scale Body Composition',
    'Digital smart scale measuring weight, body fat, BMI, and syncs with mobile app.',
    59.99,
    DATE '2023-08-21',
    XMLTYPE('<product>
               <category>Fitness</category>
               <weight unit="kg">2</weight>
               <dimensions unit="cm">30x30x3</dimensions>
               <manufacturer>FitTrack</manufacturer>
               <features>
                 <feature>Body composition</feature>
                 <feature>Mobile app sync</feature>
                 <feature>High precision</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Desk Organizer Set',
    'Set of desk organizers including pen holder, file tray, and drawer organizer.',
    29.99,
    DATE '2023-08-22',
    XMLTYPE('<product>
               <category>Office</category>
               <weight unit="kg">2</weight>
               <dimensions unit="cm">Varies</dimensions>
               <manufacturer>OfficePro</manufacturer>
               <features>
                 <feature>Multiple compartments</feature>
                 <feature>Durable material</feature>
                 <feature>Organizes desk items</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'LED Desk Lamp',
    'Adjustable LED desk lamp with touch control, brightness levels, and USB charging port.',
    49.99,
    DATE '2023-08-23',
    XMLTYPE('<product>
               <category>Home</category>
               <weight unit="kg">1.2</weight>
               <dimensions unit="cm">15x15x40</dimensions>
               <manufacturer>BrightLite</manufacturer>
               <features>
                 <feature>Adjustable arm</feature>
                 <feature>Touch control</feature>
                 <feature>USB charging</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Electric Kettle Fast Boil',
    '1.5-liter fast boiling electric kettle with auto shut-off and water level indicator.',
    39.99,
    DATE '2023-08-24',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">1.3</weight>
               <dimensions unit="cm">22x15x25</dimensions>
               <manufacturer>QuickBoil</manufacturer>
               <features>
                 <feature>Auto shut-off</feature>
                 <feature>Fast boil</feature>
                 <feature>Water level indicator</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smartphone Gimbal Stabilizer',
    '3-axis smartphone gimbal stabilizer for smooth video recording, foldable and portable.',
    99.99,
    DATE '2023-08-25',
    XMLTYPE('<product>
               <category>Photography</category>
               <weight unit="grams">500</weight>
               <dimensions unit="cm">25x12x8</dimensions>
               <manufacturer>SteadyShot</manufacturer>
               <features>
                 <feature>3-axis stabilization</feature>
                 <feature>Foldable</feature>
                 <feature>Portable</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Coffee Grinder',
    'Electric coffee grinder with adjustable grind size, 250g capacity, and easy to clean.',
    49.99,
    DATE '2023-08-26',
    XMLTYPE('<product>
               <category>Kitchen</category>
               <weight unit="kg">1.2</weight>
               <dimensions unit="cm">15x10x20</dimensions>
               <manufacturer>BrewPro</manufacturer>
               <features>
                 <feature>Adjustable grind</feature>
                 <feature>250g capacity</feature>
                 <feature>Easy cleaning</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Portable LED Projector',
    'Mini LED projector with 1080p support, HDMI/USB input, and built-in speaker.',
    129.99,
    DATE '2023-08-27',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="kg">1.2</weight>
               <dimensions unit="cm">20x15x8</dimensions>
               <manufacturer>ViewTech</manufacturer>
               <features>
                 <feature>1080p support</feature>
                 <feature>HDMI/USB input</feature>
                 <feature>Built-in speaker</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Home Security Camera',
    'WiFi security camera with 1080p video, motion detection, and night vision.',
    79.99,
    DATE '2023-08-28',
    XMLTYPE('<product>
               <category>Home Automation</category>
               <weight unit="kg">0.5</weight>
               <dimensions unit="cm">8x8x12</dimensions>
               <manufacturer>SecureHome</manufacturer>
               <features>
                 <feature>1080p video</feature>
                 <feature>Motion detection</feature>
                 <feature>Night vision</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Wireless Charging Pad',
    'Qi-certified wireless charging pad compatible with smartphones and earbuds.',
    29.99,
    DATE '2023-08-29',
    XMLTYPE('<product>
               <category>Electronics</category>
               <weight unit="grams">150</weight>
               <dimensions unit="cm">10x10x1.5</dimensions>
               <manufacturer>ChargeMax</manufacturer>
               <features>
                 <feature>Qi-certified</feature>
                 <feature>Fast charging</feature>
                 <feature>Compact design</feature>
               </features>
             </product>')
);

INSERT INTO products (name, description, price, creation_date, details_xml) VALUES (
    'Smart Thermostat',
    'WiFi smart thermostat with energy saving mode, schedule programming, and app control.',
    199.99,
    DATE '2023-08-30',
    XMLTYPE('<product>
               <category>Home Automation</category>
               <weight unit="kg">1</weight>
               <dimensions unit="cm">12x12x3</dimensions>
               <manufacturer>TempSmart</manufacturer>
               <features>
                 <feature>WiFi enabled</feature>
                 <feature>Schedule programming</feature>
                 <feature>Energy saving mode</feature>
               </features>
             </product>')
);

