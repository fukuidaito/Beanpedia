class SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      openai_client = OpenaiClient.new
      @suggestion = openai_client.suggest_coffee(@survey)
      redirect_to survey_path(@survey, suggestion: @suggestion)
    else
        render :new
    end
  end

  def show
  @survey = Survey.find(params[:id])
  @suggestion = params[:suggestion]
  end

  private

  def survey_params
  params.require(:survey).permit(:bitterness, :acidity, :body, :origin)
  end
end
  