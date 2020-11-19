# frozen_string_literal: true

class PetitionController < ApplicationController
  def create
    db_query("

        INSERT INTO petition_signatures (petition_id, email)

        VALUES (#{params[:petition_id]}, '#{params[:email]}')

   ")
    store_to_crm
    show
  end

  def show
    petition = Petition.find(params[:petition_id])
    render inline: "<p>Thank you for signing #{petition.name}</p>"
  end

  private

  def store_to_crm
    http_post("https://crm.example.org/apiv1/upsert_member?email=#{params[:email]}",
              postcode: params[:postcode])
  end
end
