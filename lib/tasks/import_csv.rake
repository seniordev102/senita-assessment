namespace :csv do
  desc "Import data from a CSV file"
  task import: :environment do
    file_path = ENV["CSV_FILE_PATH"]

    unless file_path
      puts "❌ Please provide a CSV file path using CSV_FILE_PATH=<path> rake csv:import"
      exit
    end

    unless File.exist?(file_path)
      puts "❌ File not found: #{file_path}"
      exit
    end

    puts "📥 Importing CSV file: #{file_path}..."

    CsvImportService.new(File.open(file_path)).call
    
    puts "✅ Import completed successfully!"
  end
end
