class SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      input = "あなたは親しみやすい話し方をするコーヒーの専門家です。ユーザーが好むコーヒーの特徴: 酸味=#{@survey.acidity}, 苦味=#{@survey.bitterness}, ボディ=#{@survey.body}, 風味=#{@survey.flavor}。おすすめのコーヒー豆の名前を提供してください？"
      @survey.suggestion = OpenAiService.generate_coffee_suggestion(input)
      @survey.save
      redirect_to survey_path(@survey)
    else
      render :new
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  private

  def survey_params
    params.require(:survey).permit(:acidity, :bitterness, :body, :flavor)
  end
end
  