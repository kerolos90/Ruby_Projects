require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone(phone_number)
    num_array = ["0","1","2","3","4","5","6","7","8","9"]
    p_num = ""
    phone_number.each_char do |num|
        p_num += num if num_array.include? num
    end

    if p_num.length < 10 || p_num.length > 11
        return "a bad number "
    else
        if p_num.length == 11 && p_num[0] != 1
            return "a bad number"
        elsif p_num.length == 11
            return p_num[1..3] + "-" + p_num[4..6] + "-" + p_num[7..10]
        else
            return p_num[0..2] + "-" + p_num[3..5] + "-" + p_num[6..9]
        end
    end

end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def clean_time(time_stamp)
  # p time_stamp.strftime("%l")
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'


contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

time_hash = Hash.new
day_hash = Hash.new

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = clean_phone(row[:homephone])
  zipcode = clean_zipcode(row[:zipcode])
  time = Time.strptime(row[:regdate], '%m/%d/%Y %H:%M')
  if time_hash.include?(time.strftime("%l%p"))
    time_hash[time.strftime("%l%p")] +=1
  else
    time_hash[time.strftime("%l%p")] = 1
  end

  if day_hash.include?(time.strftime("%A"))
    day_hash[time.strftime("%A")] +=1
  else
    day_hash[time.strftime("%A")] = 1
  end
  
  legislators = legislators_by_zipcode(zipcode)

  # form_letter = erb_template.result(binding)
  # save_thank_you_letter(id,form_letter)
end

puts "Most of the registrations were done at #{time_hash.key(time_hash.values.max)} and on the day of the week #{day_hash.key(day_hash.values.max)}."
