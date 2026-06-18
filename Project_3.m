disp("Aircraft Cosmic Radiation Risk Analyzer")
disp("---------------------------------------")

altitude = get_altitude();
hours = get_hours();
[dose_rate, altitude_risk, dose, percent_limit] = calculate_radiation(altitude, hours);

fprintf("\nRadiation Risk Report\n")
fprintf("---------------------\n")
fprintf("Cruise Altitude: %d ft\n", altitude)
fprintf("Time at Cruise Altitude: %.1f hr\n", hours)
fprintf("Dose Rate: %.1f uSv/hr\n", dose_rate)
fprintf("Estimated Radiation Dose: %.2f uSv\n", dose)
fprintf("Radiation Risk: %s\n", altitude_risk)
fprintf("Percent of Annual 20 mSv Limit Used: %.2f%%\n", percent_limit)

if altitude <= 30000
    fprintf("Note: Radiation dose rate is 2.5 uSv/hr or less below 30,000 ft.\n")
elseif altitude >= 42000
    fprintf("Note: Radiation above 42,000 ft is 6.6 uSv/hr or more as altitude increases.\n")
end

altitudes = [30000 35000 40000 42000];
dose_rates = [2.5 3.9 4.8 6.6];

figure
plot(altitudes, dose_rates, "-o")
title("Cosmic Radiation Dose Rate vs Cruise Altitude")
xlabel("Cruise Altitude (ft)")
ylabel("Dose Rate (uSv/hr)")
grid on

function altitude = get_altitude()
while true
    altitude = input("Enter cruise altitude in feet from 0 - 42,000 ft: ");
    if altitude < 0
        disp("Altitude cannot be negative. Please try again.")
    elseif altitude > 42000
        disp("Altitude must be 42,000 ft or less. Please try again.")
    else
        break
    end
end
end

function hours = get_hours()
while true
    hours = input("Enter time spent at cruise altitude in hours: ");
    if hours <= 0
        disp("Time must be greater than 0 hours. Please try again.")
    else
        break
    end
end
end

function [dose_rate, altitude_risk, dose, percent_limit]...
    = calculate_radiation(altitude, hours)
if altitude <= 30000
    dose_rate = 2.5;
    altitude_risk = "LOW ALTITUDE EXPOSURE";
elseif altitude <= 35000
    dose_rate = 3.9;
    altitude_risk = "MODERATE ALTITUDE EXPOSURE";
elseif altitude <= 40000
    dose_rate = 4.8;
    altitude_risk = "HIGH ALTITUDE EXPOSURE";
else
    dose_rate = 6.6;
    altitude_risk = "VERY HIGH ALTITUDE EXPOSURE";
end

dose = dose_rate * hours;
percent_limit = (dose / 20000) * 100;
end