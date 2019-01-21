require_relative "../lib/mailer"
require "sidekiq"

class MailWorker
  include Sidekiq::Worker
  
  def perform(id)
    Mailer.deliver do 
      from    "eki_#{id}@eqbalq.com"
      to      "jill_#{id}@example.com"
      subject "Threading and Forking (#{id})"
      body    "Some content"
    end  
  end
end

# ⇒  irb
# >> require_relative "mail_worker"
# => true
# >> 100.times{|i| MailWorker.perform_async(i)}
# 2014-12-20T02:42:30Z 46549 TID-ouh10w8gw INFO: Sidekiq client with redis options {}
# => 100