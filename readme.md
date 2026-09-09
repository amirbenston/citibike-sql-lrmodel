Model Summary
This project builds a linear regression model to predict daily Citi Bike ridership in NYC using weather and calendar data. The goal was to see how far temperature, precipitation, wind, day of week, and a time trend could get us in explaining day to day ride counts, and where that approach breaks down.

Data Quality

The raw dataset had a few issues that needed fixing before modeling. precip_in used a sentinel value (like -1 or 999) to mark missing readings instead of leaving them blank, so those needed to be identified and handled rather than treated as real numbers. There was also a flat, missing data period around 2017 that shows up later in the residual plots. ride_date came in as plain text and had to be converted with pd.to_datetime() every time the data was reloaded from CSV, since dtypes don't persist through a CSV round trip.

Feature Engineering

Day of week was one hot encoded into six dummy columns, dropping Friday as the baseline to avoid the dummy variable trap. A days_since_launch column was added as a trend feature to capture ridership's overall growth since the system launched, since raw calendar year alone doesn't capture that trend well. temp_f_squared was added later as a stretch feature, since EDA showed ridership climbs with temperature only up to about 80-85°F before falling off, a curve a single linear temperature term can't represent on its own.

Model Performance

The final model reached a test R² of 0.752, meaning it explains about 75% of the day to day variation in ridership on days it hasn't seen before. Test MAE was about 6,950 rides, so predictions are typically off by that much on a given day. Temperature and precipitation are the strongest drivers: each degree Fahrenheit adds roughly 567 rides, while an inch of rain costs nearly 3,874 rides. Weekends see a sharp drop compared to weekdays, consistent with a commuter driven system.

Biggest Weakness

The model's worst misses aren't random, they cluster around extreme weather events and holidays. The single worst miss was the October 29, 2017 nor'easter, a bomb cyclone with hurricane like winds; the model predicted about 42,400 rides but actual ridership was only 9,537. Christmas Day 2015, the warmest Christmas on record in NYC, produced a similar miss in the other direction. The model has no way to flag a day as a holiday or a dangerous storm rather than just rainy or warm, so it treats these events like any other data point with those weather values.

What Data Would Help Next

A holiday indicator (federal holidays plus major local events) and a severe weather flag (from NWS storm warnings, not just inches of rain) would likely close a meaningful part of this gap, since both of the worst misses trace back to exactly those two missing signals.