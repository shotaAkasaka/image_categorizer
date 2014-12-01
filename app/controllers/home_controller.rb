require 'csv'

$count = 0
$ryokan = Array.new(100000){[]}
@end_flag = false

class HomeController < ApplicationController
  def index
    if params[:commit].nil?
      csv = CSV.read('./app/assets/all.csv')
      if $count > (csv.size - 1)  then
        @end_flag = true
        return
      end
      @count_down = csv.size - $count
      for num in 0..4 do 
        $ryokan[$count][num] = csv[$count][num]
      end
    else
      $ryokan[$count][5] = params[:commit]
      CSV.open('./app/assets/all_buf.csv', 'w') do |write|
        $ryokan.each do |data|
          write << data
        end
      end
      table = CSV.table('./app/assets/all.csv')
      puts "table"
      puts table 
      puts "table"
      puts table.delete(0)
      puts table.delete(0)
      $count += 1
      redirect_to :root
      return
    end
  end
end
