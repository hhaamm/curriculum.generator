require 'erb'
require 'date'

class Curriculum
  attr_accessor :name, :birth_date, :city, :country
  def self.build(&block)
    @c = Curriculum.new
    @c.instance_eval &block
    @c
  end  

  public

  def vitae(opts, file_path)
    #TODO: implement
  end

  def cover_letter(tech)
    template_str = File.read(File.join(File.dirname(__FILE__),"cover_letter.erb"))
    renderer = ERB.new(template_str)
    puts renderer.result(binding())
  end

  private

  def initialize
    @works = []
    @education = []
  end

  # SDL methods
  def work(work_name, &block)
    work = Work.new(work_name)
    work.instance_eval &block
    @works << work
  end

  def education(detail, &block)
    # TODO: implement
  end

  def honor(detail, &block)
    # TODO: implement
  end

  def born_in(year); @birth_date = year; end;
  def age
    return Date.today.strftime("%Y").to_i - @birth_date
  end
end

class Work
  attr_reader :name, :desc, :from, :to, :samples, :techs
  def initialize(detail)
    @name = detail
    @samples = []
    @desc = {}
    @techs = []
  end

  # SDL methods
  public

  # Return the number of years working
  # If a tech is passed, returned the number of years working in that tech
  def years(tech=nil)    
    if tech
      tdata = nil
      @techs.each do |t|
        if t.name == tech
          tdata = t
        end
      end
      if tdata
        return tdata.years
      else
        return 0
      end
      # TODO: return just the time we worked with that technology
    end
    return (@to - @from).to_i / 365
  end

  # Must be public because if not it doesn't work
  def to(date)
    @to = fmt_date(date)
  end

  private
 
  def from(date)
    @from = fmt_date(date)
    # Return self so you can call the 'to' method
    self
  end

  # Formats a date from a hash
  def fmt_date(date)
    if (date == :now)
      return Date.today
    end
    if (date.is_a? Integer)
      date = {:year => date, :month => 1}
    end
    Date.parse(date[:year].to_s+"-"+date[:month].to_s+"-01")
  end

  def sample(sample_name, opts = {})
    @samples.push opts.merge(:name => sample_name)
  end

  def tech(name, time=nil)
    @techs << Tech.new(name, time)
  end

  def tool(name)
    @techs.last.tools << name
  end

  def desc(lang, desc)
    @desc[lang] = desc
  end
end

class Tech
  attr_reader :name, :years
  attr_accessor :tools
  def initialize(name, time)
    @name = name
    @tools = []
    if time == nil
      @years = nil
    else
      years = time[:years]? time[:years] : 0
      months = time[:months]? time[:months] : 0
      @years = years + months.to_f/12
    end
  end
end

