# Create 10 airline objects
10.times {FactoryGirl.create :airline}

# Create 100 flight objects
100.times {FactoryGirl.create :flight}
