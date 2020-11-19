# frozen_string_literal: true

# Handles people signing 38 Degrees petitions

# POST /petition/sign

def sign
  # parameters: petition_id, email (of petition signer), postcode

  # Save the petition signature

  db_query("

                     INSERT INTO petition_signatures (petition_id, email)

                     VALUES (#{params[:petition_id]}, '#{params[:email]}')

                ")

  # Tell CRM to store this new member, or update existing record

  http_post("https://crm.example.org/apiv1/upsert_member?email=#{params[:email]}",
            postcode: params[:postcode])

  petition = Petition.find(params[:petition_id])

  render inline: "<p>Thank you for signing #{petition.name}</p>"
 end
