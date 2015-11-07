class MagicRanker
  class << self
    def rank_reports
      assign_quality_rank
      assign_value_rank
      assign_magic_number
      assign_magic_rank
    end

    private

    def assign_quality_rank
      Report.order(return_on_capital: :desc).each_with_index do |record, i|
        record.update(quality_rank: i + 1)
      end
    end

    def assign_value_rank
      Report.order(earnings_yield: :desc).each_with_index do |record, i|
        record.update(value_rank: i + 1)
      end
    end

    def assign_magic_number
      Report.find_each do |report|
        report.update(magic_number: (report.quality_rank + report.value_rank))
      end
    end

    def assign_magic_rank
      Report.order(:magic_number).each_with_index do |record, i|
        record.update(magic_rank: i + 1)
      end
    end
  end
end
